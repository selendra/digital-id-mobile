"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.logger = void 0;
const logger_1 = require("@ethersproject/logger");
const _version_1 = require("./_version");
exports.logger = new logger_1.Logger(_version_1.version);
//# sourceMappingURL=logger.js.map