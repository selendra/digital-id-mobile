"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.calcSubstrateTransactionParams = exports.calcEthereumTransactionParams = void 0;
const ethers_1 = require("ethers");
const divRoundUp = (x, y) => {
    const mod = x.mod(y);
    const div = x.div(y);
    return div.add(mod.gt(0) ? 1 : 0);
};
const calcEthereumTransactionParams = (data) => {
    const gasLimit = ethers_1.BigNumber.from(data.gasLimit);
    const storageLimit = ethers_1.BigNumber.from(data.storageLimit);
    const validUntil = ethers_1.BigNumber.from(data.validUntil);
    const storageByteDeposit = ethers_1.BigNumber.from(data.storageByteDeposit);
    const txFeePerGas = ethers_1.BigNumber.from(data.txFeePerGas);
    const blockPeriod = divRoundUp(validUntil, ethers_1.BigNumber.from(30));
    const storageEntryLimit = divRoundUp(storageLimit, ethers_1.BigNumber.from(64));
    const storageEntryDeposit = storageByteDeposit.mul(64);
    const txGasPrice = txFeePerGas.add(blockPeriod.shl(16)).add(storageEntryLimit);
    const txGasLimit = storageEntryDeposit.div(txFeePerGas).mul(storageEntryLimit).add(gasLimit);
    return {
        txGasPrice,
        txGasLimit
    };
};
exports.calcEthereumTransactionParams = calcEthereumTransactionParams;
const calcSubstrateTransactionParams = (data) => {
    const txGasPrice = ethers_1.BigNumber.from(data.txGasPrice);
    const txGasLimit = ethers_1.BigNumber.from(data.txGasLimit);
    const storageByteDeposit = ethers_1.BigNumber.from(data.storageByteDeposit);
    const txFeePerGas = ethers_1.BigNumber.from(data.txFeePerGas);
    const storageEntryLimit = txGasPrice.and(0xffff);
    const blockPeriod = txGasPrice.sub(storageEntryLimit).sub(txFeePerGas).shr(16);
    const storageLimit = storageEntryLimit.mul(64);
    const validUntil = blockPeriod.mul(30);
    const storageEntryDeposit = storageByteDeposit.mul(64);
    const gasLimit = txGasLimit.sub(storageEntryDeposit.div(txFeePerGas).mul(storageEntryLimit));
    return {
        gasLimit,
        storageLimit,
        validUntil
    };
};
exports.calcSubstrateTransactionParams = calcSubstrateTransactionParams;
//# sourceMappingURL=transactionHelper.js.map