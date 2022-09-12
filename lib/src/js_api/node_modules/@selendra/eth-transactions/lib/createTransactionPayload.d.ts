import { SelendraEvmTXPayload } from './types';
export declare const MAX_UINT256 = "0xffffffff";
export declare const createTransactionPayload: (tx: SelendraEvmTXPayload) => {
    types: {
        EIP712Domain: {
            name: string;
            type: string;
        }[];
        AccessList: {
            name: string;
            type: string;
        }[];
        Transaction: {
            name: string;
            type: string;
        }[];
    };
    primaryType: "Transaction";
    domain: {
        name: string;
        version: string;
        chainId: import("@ethersproject/bignumber").BigNumberish;
        salt: string;
    };
    message: {
        action: "Create" | "Call";
        to: string;
        nonce: string;
        tip: string;
        data: string;
        value: string;
        gasLimit: string;
        storageLimit: string;
        accessList: import("@ethersproject/transactions").AccessList;
        validUntil: string;
    };
};
//# sourceMappingURL=createTransactionPayload.d.ts.map