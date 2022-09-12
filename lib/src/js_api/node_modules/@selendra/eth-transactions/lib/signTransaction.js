"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.signTransaction = void 0;
const bytes_1 = require("@ethersproject/bytes");
const hash_1 = require("@ethersproject/hash");
const wallet_1 = require("@ethersproject/wallet");
const createTransactionPayload_1 = require("./createTransactionPayload");
const signTransaction = (privateKey, tx) => {
    const payload = (0, createTransactionPayload_1.createTransactionPayload)(tx);
    const wallet = new wallet_1.Wallet(privateKey);
    return (0, bytes_1.joinSignature)(wallet._signingKey().signDigest(hash_1._TypedDataEncoder.hash(payload.domain, {
        AccessList: payload.types.AccessList,
        Transaction: payload.types.Transaction
    }, payload.message)));
};
exports.signTransaction = signTransaction;
//# sourceMappingURL=signTransaction.js.map