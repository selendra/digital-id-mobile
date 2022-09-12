import { ApiPromise } from '@polkadot/api';
import type { ApiOptions } from '@polkadot/api/types';
export declare const defaultOptions: ApiOptions;
export declare const createApiOptions: ({ types, rpc, typesAlias, typesBundle, signedExtensions, ...otherOptions }?: ApiOptions) => ApiOptions;
export declare const createApi: (endpoints: string | string[], apiOptions?: ApiOptions | undefined) => ApiPromise;
//# sourceMappingURL=chain-api.d.ts.map