import type { HexString } from '@polkadot/util/types';
export declare const isSubstrateAddress: (address: HexString | string | Uint8Array) => boolean;
export declare const isEvmAddress: (address: string) => boolean;
export declare const computeDefaultEvmAddress: (substrateAddress: HexString | string | Uint8Array) => string;
export declare const computeDefaultSubstrateAddress: (evmAddress: string) => string;
//# sourceMappingURL=address.d.ts.map