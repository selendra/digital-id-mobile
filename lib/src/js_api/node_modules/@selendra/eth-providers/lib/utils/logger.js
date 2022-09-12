"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.throwNotImplemented = exports.PROVIDER_ERRORS = exports.logger = void 0;
const logger_1 = require("@ethersproject/logger");
const _version_1 = require("../_version");
exports.logger = new logger_1.Logger(_version_1.version);
var PROVIDER_ERRORS;
(function (PROVIDER_ERRORS) {
    // When the specified block height or hash is not found
    PROVIDER_ERRORS["HEADER_NOT_FOUND"] = "HEADER_NOT_FOUND";
})(PROVIDER_ERRORS = exports.PROVIDER_ERRORS || (exports.PROVIDER_ERRORS = {}));
const throwNotImplemented = (method) => {
    return exports.logger.throwError(`${method} not implemented`, logger_1.Logger.errors.NOT_IMPLEMENTED, {
        method,
        provider: 'eth-providers'
    });
};
exports.throwNotImplemented = throwNotImplemented;
//# sourceMappingURL=logger.js.map