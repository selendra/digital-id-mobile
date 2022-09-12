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
exports.checkSignatureType = exports.parseTransaction = exports.parseEip712 = void 0;
const address_1 = require("@ethersproject/address");
const bignumber_1 = require("@ethersproject/bignumber");
const bytes_1 = require("@ethersproject/bytes");
const constants_1 = require("@ethersproject/constants");
const logger_1 = require("@ethersproject/logger");
const RLP = __importStar(require("@ethersproject/rlp"));
const transactions_1 = require("@ethersproject/transactions");
const logger_2 = require("./logger");
const serializeTransaction_1 = require("./serializeTransaction");
const transactionHash_1 = require("./transactionHash");
const verifyTransaction_1 = require("./verifyTransaction");
const EIP712_PARAMS_LENGTH = 10;
function handleNumber(value) {
    if (value === '0x') {
        return constants_1.Zero;
    }
    return bignumber_1.BigNumber.from(value);
}
function handleAddress(value) {
    if (value === '0x') {
        return null;
    }
    return (0, address_1.getAddress)(value);
}
function _parseEip712Signature(tx, fields, serialize) {
    try {
        const recid = handleNumber(fields[0]).toNumber();
        if (recid !== 0 && recid !== 1) {
            throw new Error('bad recid');
        }
        tx.v = recid;
    }
    catch (error) {
        logger_2.logger.throwArgumentError('invalid v for transaction type: 1', 'v', fields[0]);
    }
    tx.r = (0, bytes_1.hexZeroPad)(fields[1], 32);
    tx.s = (0, bytes_1.hexZeroPad)(fields[2], 32);
    tx.from = (0, verifyTransaction_1.verifyTransaction)({
        chainId: tx.chainId,
        salt: tx.salt,
        nonce: tx.nonce,
        gasLimit: tx.gasLimit,
        storageLimit: tx.storageLimit,
        to: tx.to,
        value: tx.value,
        data: tx.data,
        validUntil: tx.validUntil,
        tip: tx.tip,
        accessList: tx.accessList
    }, (0, bytes_1.joinSignature)({ r: tx.r, s: tx.s, v: tx.v }));
}
// rlp([chainId, salt, nonce, gasLimit, storageLimit, to, value, data, validUntil, tip, accessList, eip712sig])
function parseEip712(payload) {
    const transaction = RLP.decode(payload.slice(1));
    if (transaction.length !== EIP712_PARAMS_LENGTH + 1 && transaction.length !== EIP712_PARAMS_LENGTH + 4) {
        logger_2.logger.throwArgumentError('invalid component count for transaction type: 96', 'payload', (0, bytes_1.hexlify)(payload));
    }
    const tx = {
        type: 96,
        chainId: handleNumber(transaction[0]).toNumber(),
        salt: transaction[1],
        nonce: handleNumber(transaction[2]).toNumber(),
        gasLimit: handleNumber(transaction[3]),
        storageLimit: handleNumber(transaction[4]),
        // @ts-ignore
        to: handleAddress(transaction[5]),
        value: handleNumber(transaction[6]),
        data: transaction[7],
        validUntil: handleNumber(transaction[8]),
        tip: handleNumber(transaction[9]),
        accessList: (0, transactions_1.accessListify)(transaction[10])
    };
    // Unsigned EIP-712 Transaction
    if (transaction.length === EIP712_PARAMS_LENGTH + 1) {
        return tx;
    }
    tx.hash = (0, transactionHash_1.transactionHash)({
        chainId: tx.chainId,
        salt: tx.salt,
        storageLimit: tx.storageLimit,
        validUntil: tx.validUntil,
        nonce: tx.nonce,
        gasLimit: tx.gasLimit,
        to: tx.to,
        value: tx.value,
        data: tx.data,
        tip: tx.tip,
        accessList: tx.accessList
    });
    _parseEip712Signature(tx, transaction.slice(EIP712_PARAMS_LENGTH + 1), serializeTransaction_1.serializeEip712);
    return tx;
}
exports.parseEip712 = parseEip712;
function parseTransaction(rawTransaction) {
    const payload = (0, bytes_1.arrayify)(rawTransaction);
    // Ethereum Transactions
    if (payload[0] > 0x7f || payload[0] === 1 || payload[0] === 2) {
        return (0, transactions_1.parse)(payload);
    }
    // EIP 712
    if (payload[0] === 96) {
        return parseEip712(payload);
    }
    return logger_2.logger.throwError(`unsupported transaction type: ${payload[0]}`, logger_1.Logger.errors.UNSUPPORTED_OPERATION, {
        operation: 'parseTransaction',
        transactionType: payload[0]
    });
}
exports.parseTransaction = parseTransaction;
function checkSignatureType(rawTransaction) {
    const payload = (0, bytes_1.arrayify)(rawTransaction);
    if (payload[0] > 0x7f || payload[0] === 1)
        return 'Ethereum'; // Legacy and EIP-155
    if (payload[0] === 2)
        return 'Eip1559'; // EIP-1559
    if (payload[0] === 96)
        return 'SelendraEip712'; // Selendra EIP-712
    return logger_2.logger.throwError(`unsupported transaction type: ${payload[0]}`, logger_1.Logger.errors.UNSUPPORTED_OPERATION, {
        operation: 'checkSignatureType',
        transactionType: payload[0]
    });
}
exports.checkSignatureType = checkSignatureType;
//# sourceMappingURL=parseTransaction.js.map