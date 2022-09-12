"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TX_RECEIPT_NODES = exports.LOGS_NODES = exports.adaptLogs = exports.getLogsQueryFilter = exports.filterLog = exports.filterLogByAddress = exports.filterLogByTopics = void 0;
// https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_newfilter
const filterLogByTopics = (log, topics) => {
    if (!topics || topics.length === 0)
        return true;
    for (const [i, targetTopic] of topics.entries()) {
        if (i > 3)
            break; // max 4 topics
        const curTopic = log.topics[i]?.toLowerCase();
        if (typeof targetTopic === 'string') {
            if (curTopic !== targetTopic.toLowerCase())
                return false;
        }
        else if (Array.isArray(targetTopic) && targetTopic.length > 0) {
            if (!targetTopic.map((x) => x.toLowerCase()).includes(curTopic))
                return false;
        }
    }
    return true;
};
exports.filterLogByTopics = filterLogByTopics;
const filterLogByAddress = (log, targetAddr) => {
    if (!targetAddr || (Array.isArray(targetAddr) && targetAddr.length === 0))
        return true;
    const logAddr = log.address.toLowerCase();
    if (typeof targetAddr === 'string') {
        if (logAddr !== targetAddr.toLowerCase())
            return false;
    }
    else if (Array.isArray(targetAddr)) {
        if (!targetAddr.map((x) => x.toLowerCase()).includes(logAddr))
            return false;
    }
    return true;
};
exports.filterLogByAddress = filterLogByAddress;
// it's for eth_subscribe, and a little bit different than general log filter
const filterLog = (log, filter) => (0, exports.filterLogByAddress)(log, filter.address) && (0, exports.filterLogByTopics)(log, filter.topics);
exports.filterLog = filterLog;
/* --------------------------------------------------- */
/* --------------- log utils for Subql --------------- */
/* --------------------------------------------------- */
const isEffectiveFilter = (x) => x !== undefined && x !== null && !(Array.isArray(x) && x.length === 0);
const isAnyFilterEffective = (arr) => arr.some((a) => isEffectiveFilter(a));
const _getBlockNumberFilter = (fromBlock, toBlock) => {
    const fromBlockFilter = isEffectiveFilter(fromBlock) ? `greaterThanOrEqualTo: "${fromBlock}"` : '';
    const toBlockFilter = isEffectiveFilter(toBlock) ? `lessThanOrEqualTo: "${toBlock}"` : '';
    return !!fromBlockFilter || !!toBlockFilter
        ? `blockNumber: {
    ${fromBlockFilter}
    ${toBlockFilter}
  }`
        : '';
};
const _getAddressFilter = (address) => address ? `address: { inInsensitive: ${JSON.stringify(Array.isArray(address) ? address : [address])}}` : '';
const getLogsQueryFilter = (filter) => {
    const { fromBlock, toBlock, address } = filter;
    if (!isAnyFilterEffective([fromBlock, toBlock, address])) {
        return '';
    }
    const addressFilter = _getAddressFilter(address);
    const blockNumberFilter = _getBlockNumberFilter(fromBlock, toBlock);
    // subql don't filter topics since it's impossible to implement standard bloom filter here
    // can still add some first round loose topics filter to decrease result size if needed
    const queryFilter = `(filter: {
    ${addressFilter}
    ${blockNumberFilter}
  })`;
    return queryFilter;
};
exports.getLogsQueryFilter = getLogsQueryFilter;
// adapt logs from graphql to provider compatible types
const adaptLogs = (logs) => logs.map((log) => ({
    ...log,
    data: log.data || ''
}));
exports.adaptLogs = adaptLogs;
exports.LOGS_NODES = `
  nodes {
    blockNumber,
    blockHash,
    transactionIndex,
    removed,
    address,
    data,
    topics,
    transactionHash,
    logIndex,
  }
`;
exports.TX_RECEIPT_NODES = `
  nodes {
    id
    to
    from
    contractAddress
    transactionIndex
    gasUsed
    logsBloom
    blockHash
    transactionHash
    blockNumber
    cumulativeGasUsed
    effectiveGasPrice,
    type
    status
    logs {
      ${exports.LOGS_NODES}
    }
  }
`;
//# sourceMappingURL=logs.js.map