"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SubqlProvider = void 0;
const graphql_request_1 = require("graphql-request");
const logs_1 = require("./logs");
class SubqlProvider {
    constructor(url) {
        this.queryGraphql = (query) => (0, graphql_request_1.request)(this.url, (0, graphql_request_1.gql) `
        ${query}
      `);
        this.getAllTxReceipts = async () => {
            const res = await this.queryGraphql(`
      query {
        transactionReceipts {
          ${logs_1.TX_RECEIPT_NODES}
        }
      }
    `);
            return res.transactionReceipts.nodes;
        };
        this.getTxReceiptByHash = async (hash) => {
            const res = await this.queryGraphql(`
      query {
        transactionReceipts(filter: {
          transactionHash:{
            equalTo: "${hash}"
          }
        }) {
          ${logs_1.TX_RECEIPT_NODES}
        }
      }
    `);
            return res.transactionReceipts.nodes[0] || null;
        };
        this.getAllLogs = async () => {
            const res = await this.queryGraphql(`
      query {
        logs {
          ${logs_1.LOGS_NODES}
        }
      }
    `);
            return (0, logs_1.adaptLogs)(res.logs.nodes);
        };
        this.getFilteredLogs = async (filter) => {
            const queryFilter = (0, logs_1.getLogsQueryFilter)(filter);
            const res = await this.queryGraphql(`
      query {
        logs${queryFilter} {
          ${logs_1.LOGS_NODES}
        }
      }
    `);
            return (0, logs_1.adaptLogs)(res.logs.nodes);
        };
        this.getIndexerMetadata = async () => {
            const res = await this.queryGraphql(`
      query {
        _metadata {
          lastProcessedHeight
          lastProcessedTimestamp
          targetHeight
          chain
          specName
          genesisHash
          indexerHealthy
          indexerNodeVersion
        }
      }
    `);
            return res._metadata;
        };
        this.url = url;
    }
}
exports.SubqlProvider = SubqlProvider;
//# sourceMappingURL=subqlProvider.js.map