"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.transactionHash = void 0;
const createTransactionPayload_1 = require("./createTransactionPayload");
const hash_1 = require("@ethersproject/hash");
const transactionHash = (tx) => {
    const payload = (0, createTransactionPayload_1.createTransactionPayload)(tx);
    return hash_1._TypedDataEncoder.hash(payload.domain, {
        AccessList: payload.types.AccessList,
        Transaction: payload.types.Transaction
    }, payload.message);
};
exports.transactionHash = transactionHash;
//# sourceMappingURL=transactionHash.js.map