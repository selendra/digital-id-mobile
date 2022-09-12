import { BigNumber, BigNumberish } from 'ethers';
declare type TxConsts = {
    storageByteDeposit: BigNumberish;
    txFeePerGas: BigNumberish;
};
export declare const calcEthereumTransactionParams: (data: {
    gasLimit: BigNumberish;
    storageLimit: BigNumberish;
    validUntil: BigNumberish;
} & TxConsts) => {
    txGasPrice: BigNumber;
    txGasLimit: BigNumber;
};
export declare const calcSubstrateTransactionParams: (data: {
    txGasPrice: BigNumberish;
    txGasLimit: BigNumberish;
} & TxConsts) => {
    gasLimit: BigNumber;
    storageLimit: BigNumber;
    validUntil: BigNumber;
};
export {};
//# sourceMappingURL=transactionHelper.d.ts.map