"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createClaimSignature = void 0;
const bytes_1 = require("@ethersproject/bytes");
const hash_1 = require("@ethersproject/hash");
const wallet_1 = require("@ethersproject/wallet");
const createClaimPayload_1 = require("./createClaimPayload");
const createClaimSignature = (privateKey, tx) => {
    const payload = (0, createClaimPayload_1.createClaimPayload)(tx);
    const wallet = new wallet_1.Wallet(privateKey);
    return (0, bytes_1.joinSignature)(wallet._signingKey().signDigest(hash_1._TypedDataEncoder.hash(payload.domain, {
        Transaction: payload.types.Transaction
    }, payload.message)));
};
exports.createClaimSignature = createClaimSignature;
//# sourceMappingURL=createClaimSignature.js.map