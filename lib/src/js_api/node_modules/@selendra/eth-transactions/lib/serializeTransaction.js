"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.serializeTransaction = exports.serializeEip712 = void 0;
const address_1 = require("@ethersproject/address");
const bignumber_1 = require("@ethersproject/bignumber");
const bytes_1 = require("@ethersproject/bytes");
const logger_1 = require("@ethersproject/logger");
const RLP = __importStar(require("@ethersproject/rlp"));
const transactions_1 = require("@ethersproject/transactions");
const createTransactionPayload_1 = require("./createTransactionPayload");
const logger_2 = require("./logger");
function formatAccessList(value) {
    return (0, transactions_1.accessListify)(value).map((set) => [set.address, set.storageKeys]);
}
function formatNumber(value, name) {
    const result = (0, bytes_1.stripZeros)(bignumber_1.BigNumber.from(value).toHexString());
    if (result.length > 32) {
        logger_2.logger.throwArgumentError('invalid length for ' + name, 'transaction:' + name, value);
    }
    return result;
}
// rlp([chainId, salt, nonce, gasLimit, storageLimit, to, value, data, validUntil, tip, accessList, eip712sig])
function serializeEip712(transaction, signature) {
    const fields = [
        formatNumber(transaction.chainId || 0, 'chainId'),
        transaction.salt || '0x',
        formatNumber(transaction.nonce || 0, 'nonce'),
        formatNumber(transaction.gasLimit || 0, 'gasLimit'),
        formatNumber(transaction.storageLimit || 0, 'storageLimit'),
        transaction.to === null || transaction.to === undefined ? '0x' : (0, address_1.getAddress)(transaction.to),
        formatNumber(transaction.value || 0, 'value'),
        transaction.data || '0x',
        formatNumber(transaction.validUntil || createTransactionPayload_1.MAX_UINT256, 'validUntil'),
        formatNumber(transaction.tip || 0, 'tip'),
        formatAccessList(transaction.accessList || [])
    ];
    if (signature) {
        const sig = (0, bytes_1.splitSignature)(signature);
        fields.push(formatNumber(sig.recoveryParam, 'recoveryParam'));
        fields.push((0, bytes_1.stripZeros)(sig.r));
        fields.push((0, bytes_1.stripZeros)(sig.s));
    }
    return (0, bytes_1.hexConcat)(['0x60', RLP.encode(fields)]);
}
exports.serializeEip712 = serializeEip712;
function serializeTransaction(transaction, signature) {
    // Ethereum Transactions
    if (transaction.type === null ||
        transaction.type === undefined ||
        transaction.type === 0 ||
        transaction.type === 1 ||
        transaction.type === 2) {
        return (0, transactions_1.serialize)(transaction, signature);
    }
    // eip712
    if (transaction.type === 96) {
        return serializeEip712(transaction, signature);
    }
    return logger_2.logger.throwError(`unsupported transaction type: ${transaction.type}`, logger_1.Logger.errors.UNSUPPORTED_OPERATION, {
        operation: 'serializeTransaction',
        transactionType: transaction.type
    });
}
exports.serializeTransaction = serializeTransaction;
//# sourceMappingURL=serializeTransaction.js.map