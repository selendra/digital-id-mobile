"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SignerProvider = void 0;
const api_1 = require("@polkadot/api");
const base_provider_1 = require("./base-provider");
const chain_api_1 = require("./chain-api");
class SignerProvider extends base_provider_1.BaseProvider {
    constructor(apiOptions) {
        super();
        const api = new api_1.ApiPromise((0, chain_api_1.createApiOptions)(apiOptions));
        this.setApi(api);
    }
    static from(apiOptions) {
        return new SignerProvider(apiOptions);
    }
}
exports.SignerProvider = SignerProvider;
//# sourceMappingURL=signer-provider.js.map