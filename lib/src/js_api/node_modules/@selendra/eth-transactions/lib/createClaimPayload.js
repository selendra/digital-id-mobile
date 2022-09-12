"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createClaimPayload = void 0;
const bytes_1 = require("@ethersproject/bytes");
const util_crypto_1 = require("@polkadot/util-crypto");
const logger_1 = require("./logger");
// eslint-disable-next-line
const createClaimPayload = (tx) => {
    if (!tx.salt) {
        return logger_1.logger.throwError('claim payload missing salt');
    }
    if (!tx.chainId) {
        return logger_1.logger.throwError('claim payload missing chainId');
    }
    if (!tx.substrateAddress) {
        return logger_1.logger.throwError('claim payload missing substrateAddress');
    }
    let publicKey;
    try {
        publicKey = (0, util_crypto_1.decodeAddress)(tx.substrateAddress);
    }
    catch {
        return logger_1.logger.throwError('invalid substrateAddress');
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
            Transaction: [{ name: 'substrateAddress', type: 'bytes' }]
        },
        primaryType: 'Transaction',
        domain: {
            name: 'Selendra EVM claim',
            version: '1',
            chainId: tx.chainId,
            salt: (0, bytes_1.hexlify)(tx.salt)
        },
        message: {
            substrateAddress: (0, bytes_1.hexlify)(publicKey)
        }
    };
};
exports.createClaimPayload = createClaimPayload;
//# sourceMappingURL=createClaimPayload.js.map