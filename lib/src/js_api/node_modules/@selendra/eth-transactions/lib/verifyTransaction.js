"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.verifyTransaction = void 0;
const wallet_1 = require("@ethersproject/wallet");
const createTransactionPayload_1 = require("./createTransactionPayload");
const verifyTransaction = (tx, signature) => {
    const payload = (0, createTransactionPayload_1.createTransactionPayload)(tx);
    return (0, wallet_1.verifyTypedData)(payload.domain, {
        AccessList: payload.types.AccessList,
        Transaction: payload.types.Transaction
    }, payload.message, signature);
};
exports.verifyTransaction = verifyTransaction;
//# sourceMappingURL=verifyTransaction.js.map