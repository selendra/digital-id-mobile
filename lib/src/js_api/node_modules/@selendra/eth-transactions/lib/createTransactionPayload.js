"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createTransactionPayload = exports.MAX_UINT256 = void 0;
const bignumber_1 = require("@ethersproject/bignumber");
const bytes_1 = require("@ethersproject/bytes");
const logger_1 = require("./logger");
const transactions_1 = require("@ethersproject/transactions");
exports.MAX_UINT256 = '0xffffffff';
// eslint-disable-next-line
const createTransactionPayload = (tx) => {
    if (!tx.salt) {
        return logger_1.logger.throwError('eip712tx missing salt');
    }
    if (!tx.chainId) {
        return logger_1.logger.throwError('eip712tx missing chainId');
    }
    return {
        types: {
            EIP712Domain: [
                {
                    name: 'name',
                    type: 'string'
                },
                {
                    name: 'version',
                    type: 'string'
                },
                {
                    name: 'chainId',
                    type: 'uint256'
                },
                {
                    name: 'salt',
                    type: 'bytes32'
                }
            ],
            AccessList: [
                { name: 'address', type: 'address' },
                { name: 'storageKeys', type: 'uint256[]' }
            ],
            Transaction: [
                { name: 'action', type: 'string' },
                { name: 'to', type: 'address' },
                { name: 'nonce', type: 'uint256' },
                { name: 'tip', type: 'uint256' },
                { name: 'data', type: 'bytes' },
                { name: 'value', type: 'uint256' },
                { name: 'gasLimit', type: 'uint256' },
                { name: 'storageLimit', type: 'uint256' },
                { name: 'accessList', type: 'AccessList[]' },
                { name: 'validUntil', type: 'uint256' }
            ]
        },
        primaryType: 'Transaction',
        domain: {
            name: 'Selendra EVM',
            version: '1',
            chainId: tx.chainId,
            salt: (0, bytes_1.hexlify)(tx.salt || '0x')
        },
        message: {
            action: tx.action || (tx.to ? 'Call' : 'Create'),
            to: tx.to || '0x0000000000000000000000000000000000000000',
            nonce: bignumber_1.BigNumber.from(tx.nonce).toString(),
            tip: bignumber_1.BigNumber.from(tx.tip || 0).toString(),
            data: (0, bytes_1.hexlify)(tx.data || '0x'),
            value: bignumber_1.BigNumber.from(tx.value || 0).toString(),
            gasLimit: bignumber_1.BigNumber.from(tx.gasLimit || 0).toString(),
            storageLimit: bignumber_1.BigNumber.from(tx.storageLimit || 0).toString(),
            accessList: tx.accessList ? (0, transactions_1.accessListify)(tx.accessList) : [],
            validUntil: bignumber_1.BigNumber.from(tx.validUntil || exports.MAX_UINT256).toString()
        }
    };
};
exports.createTransactionPayload = createTransactionPayload;
//# sourceMappingURL=createTransactionPayload.js.map