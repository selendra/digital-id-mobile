import { SignatureLike } from '@ethersproject/bytes';
import { UnsignedSelendraEvmTX } from './types';
export declare function serializeEip712(transaction: UnsignedSelendraEvmTX, signature?: SignatureLike): string;
export declare function serializeTransaction(transaction: UnsignedSelendraEvmTX, signature?: SignatureLike): string;
//# sourceMappingURL=serializeTransaction.d.ts.map