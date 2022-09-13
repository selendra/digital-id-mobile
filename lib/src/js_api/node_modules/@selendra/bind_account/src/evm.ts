import { ethers } from 'ethers';
import { Wallet } from '@ethersproject/wallet';

export async function evm_balances(rpcProvider: string, address: string){   
    const provider = new ethers.providers.StaticJsonRpcProvider(rpcProvider);
    const balance = ethers.utils.formatEther(await provider.getBalance(address));
    return parseFloat(balance);
};

export function evm_address(privateKey: string) {
    const wallet = new Wallet(privateKey);
    return wallet.address
}