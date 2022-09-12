"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.computeDefaultSubstrateAddress = exports.computeDefaultEvmAddress = exports.isEvmAddress = exports.isSubstrateAddress = void 0;
const address_1 = require("@ethersproject/address");
const util_1 = require("@polkadot/util");
const util_crypto_1 = require("@polkadot/util-crypto");
const logger_1 = require("./logger");
const isSubstrateAddress = (address) => {
    try {
        (0, util_crypto_1.decodeAddress)(address);
        return true;
    }
    catch {
        return false;
    }
};
exports.isSubstrateAddress = isSubstrateAddress;
const isEvmAddress = (address) => {
    try {
        (0, address_1.getAddress)(address);
        return true;
    }
    catch {
        return false;
    }
};
exports.isEvmAddress = isEvmAddress;
const computeDefaultEvmAddress = (substrateAddress) => {
    if (!exports.isSubstrateAddress) {
        return logger_1.logger.throwArgumentError('invalid substrate address', 'address', substrateAddress);
    }
    const publicKey = (0, util_crypto_1.decodeAddress)(substrateAddress);
    const isStartWithEvm = (0, util_1.u8aEq)('evm:', publicKey.slice(0, 4));
    if (isStartWithEvm) {
        return (0, address_1.getAddress)((0, util_1.u8aToHex)(publicKey.slice(4, 24)));
    }
    return (0, address_1.getAddress)((0, util_1.u8aToHex)((0, util_crypto_1.blake2AsU8a)((0, util_1.u8aConcat)('evm:', publicKey), 256).slice(0, 20)));
};
exports.computeDefaultEvmAddress = computeDefaultEvmAddress;
const computeDefaultSubstrateAddress = (evmAddress) => {
    if (!(0, exports.isEvmAddress)(evmAddress)) {
        return logger_1.logger.throwArgumentError('invalid evm address', 'address', evmAddress);
    }
    const address = (0, util_crypto_1.encodeAddress)((0, util_1.u8aFixLength)((0, util_1.u8aConcat)('evm:', (0, util_1.hexToU8a)(evmAddress)), 256, true));
    return address.toString();
};
exports.computeDefaultSubstrateAddress = computeDefaultSubstrateAddress;
//# sourceMappingURL=address.js.map