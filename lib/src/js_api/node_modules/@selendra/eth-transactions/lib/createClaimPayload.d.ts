import { ClaimPayload } from './types';
export declare const createClaimPayload: (tx: ClaimPayload) => {
    types: {
        EIP712Domain: {
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
        substrateAddress: string;
    };
};
//# sourceMappingURL=createClaimPayload.d.ts.map