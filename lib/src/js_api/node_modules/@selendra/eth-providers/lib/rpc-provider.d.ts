import { BaseProvider, BaseProviderOptions } from './base-provider';
export declare class EvmRpcProvider extends BaseProvider {
    constructor(endpoint: string | string[], opts?: BaseProviderOptions);
    static from(endpoint: string | string[], opt?: BaseProviderOptions): EvmRpcProvider;
}
//# sourceMappingURL=rpc-provider.d.ts.map