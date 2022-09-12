import { BytesLike } from '@ethersproject/bytes';
import { SelendraEvmTX } from './types';
export declare type SignatureType = 'Ethereum' | 'SelendraEip712' | 'Eip1559';
export declare function parseEip712(payload: Uint8Array): SelendraEvmTX;
export declare function parseTransaction(rawTransaction: BytesLike): SelendraEvmTX;
export declare function checkSignatureType(rawTransaction: BytesLike): SignatureType;
//# sourceMappingURL=parseTransaction.d.ts.map