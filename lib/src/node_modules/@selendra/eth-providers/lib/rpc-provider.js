"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.EvmRpcProvider = void 0;
const base_provider_1 = require("./base-provider");
const chain_api_1 = require("./chain-api");
class EvmRpcProvider extends base_provider_1.BaseProvider {
    constructor(endpoint, opts) {
        super(opts);
        const api = (0, chain_api_1.createApi)(endpoint);
        this.setApi(api);
        this.startSubscription();
    }
    static from(endpoint, opt) {
        return new EvmRpcProvider(endpoint, opt);
    }
}
exports.EvmRpcProvider = EvmRpcProvider;
//# sourceMappingURL=rpc-provider.js.map