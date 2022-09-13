import { options } from "@selendra/api";
import { ApiPromise, WsProvider, Keyring } from "@polkadot/api";
// import { create_signature } from "./create_signature";
// import { evm_balances, evm_address } from "./evm";
import { createClaimSignature } from '@selendra/eth-transactions';
import { Wallet } from '@ethersproject/wallet';

import { ethers } from 'ethers';
import { EvmRpcProvider } from "@selendra/eth-providers/lib/rpc-provider";

async function bindAccount(
    substrateMnenonic: string,
    privateKey: string,
    substrateProvider:string,
    evmProverider: string
  ){

    console.log("substrateMnenonic", substrateMnenonic);
    console.log("privateKey", privateKey);
    console.log("substrateProvider", substrateProvider);
    console.log("evmProverider", evmProverider);

    const provider = new WsProvider(substrateProvider);
    const api = new ApiPromise(options({ provider }));
    await api.isReadyOrError;

    const keyring = new Keyring({
      type: 'sr25519',
      ss58Format: 204
    });

    const evmProvider = EvmRpcProvider.from(evmProverider);
    await evmProvider.isReady();
    
    const substrateWallet = keyring.addFromMnemonic(substrateMnenonic);
    const genesisHash:string = api.genesisHash.toString();
    const chainId: number = parseInt(api.consts.evmAccounts.chainId.toString());
    const evmAddress: string = evm_address(privateKey);
    const balance:number = parseFloat(await ethers.utils.formatEther(await evmProvider.getBalance(evmAddress)));//evm_balances(evmProverider, evmAddress);

    if (balance > 0){
      throw new Error('Account already exit, please use new evm account');
    };

    const signature = create_signature(privateKey, genesisHash, chainId, substrateWallet.address);

    const hash = await api.tx.evmAccounts
      .claimAccount(evmAddress, signature)
      .signAndSend(substrateWallet);

    return hash;
}

export function evm_address(privateKey: string) {
    const wallet = new Wallet(privateKey);
    return wallet.address
}

function create_signature(
    privateKey: string,
    genesisHash: string,
    chainId: number,
    substrateAddress: string
){
    const wallet = new Wallet(privateKey);
    const signature = createClaimSignature(wallet.privateKey, {
        salt: genesisHash,
        chainId: chainId,
        substrateAddress: substrateAddress
    });

    return signature
}

export default {
  bindAccount
}