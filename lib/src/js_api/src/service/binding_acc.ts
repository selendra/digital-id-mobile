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

    try {
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
      console.log("await evmProvider.isReady()", await evmProvider.isReady());
      const substrateWallet = keyring.addFromMnemonic(substrateMnenonic);
      console.log("substrateWallet", substrateWallet);
      const genesisHash:string = api.genesisHash.toString();
      console.log("genesisHash", genesisHash);
      const chainId: number = parseInt(api.consts.evmAccounts.chainId.toString());
      console.log("chainId", chainId);
      const evmAddress: string = evm_address(privateKey);
      console.log("evmAddress", evmAddress);
      const balance:number = parseFloat(await ethers.utils.formatEther(await evmProvider.getBalance(evmAddress)));//evm_balances(evmProverider, evmAddress);
      console.log("balance", balance);
      
      if (balance > 0){
        throw new Error("Account already exit, please use new evm account");
      };
      
      const signature = create_signature(privateKey, genesisHash, chainId, substrateWallet.address);
      
      console.log("signature", signature);
      
      const hash = await api.tx.evmAccounts
        .claimAccount(evmAddress, signature)
        .signAndSend(substrateWallet);
      console.log("hash", hash);
      return {"status": true, "hash": hash};
    } catch (e){

      console.log("Error", e.message);
      // throw error;
      return {"status": false, "error": e.message};
    }
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

export async function signMessage(message: string, privateKey: string) {
  console.log("signMessage");
  console.log("message", message);
  console.log("privateKey", privateKey);
  const wallet = new Wallet(privateKey);

  return await wallet.signMessage(message);
  
}
 

export default {
  bindAccount,
  signMessage
}