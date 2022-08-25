"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.hexlifyRpcResult = void 0;
const bignumber_1 = require("@ethersproject/bignumber");
const bytes_1 = require("@ethersproject/bytes");
const hexlifyRpcResult = (data) => {
    if (data === null || data === undefined)
        return data;
    if (typeof data === 'boolean')
        return data;
    if (bignumber_1.BigNumber.isBigNumber(data)) {
        return (0, bytes_1.hexValue)(data);
    }
    if (Array.isArray(data)) {
        return data.map((item) => {
            return (0, exports.hexlifyRpcResult)(item);
        });
    }
    if (data && typeof data === 'object') {
        const keys = Object.keys(data);
        const result = {};
        for (const key of keys) {
            result[key] = (0, exports.hexlifyRpcResult)(data[key]);
        }
        return result;
    }
    if (typeof data === 'number') {
        return (0, bytes_1.hexValue)(data);
    }
    if ((0, bytes_1.isHexString)(data)) {
        return data.toLowerCase();
    }
    return data;
};
exports.hexlifyRpcResult = hexlifyRpcResult;
//# sourceMappingURL=hexlifyRpcResult.js.map