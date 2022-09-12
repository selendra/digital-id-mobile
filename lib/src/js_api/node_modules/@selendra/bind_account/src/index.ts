import { options } from "@selendra/api";
import { ApiPromise, WsProvider, Keyring } from "@polkadot/api";
import { create_signature } from "./create_signature";
import { evm_balances, evm_address } from "./evm";

export async function bindaccount(
    substrateMnenonic: string,
    privateKey: string,
    substrateProvider:string,
    evmProverider: string
  ){
    const provider = new WsProvider(substrateProvider);
    const api = new ApiPromise(options({ provider }));
    await api.isReadyOrError;

    const keyring = new Keyring({
      type: 'sr25519',
      ss58Format: 204
    });

    const substrateWallet = keyring.addFromMnemonic(substrateMnenonic);
    const genesisHash:string = api.genesisHash.toString();
    const chainId: number = parseInt(api.consts.evmAccounts.chainId.toString());
    const evmAddress: string = evm_address(privateKey);
    const balance:number = await evm_balances(evmProverider, evmAddress);

    if (balance > 0){
      throw new Error('Account already exit, please use new evm account');
    };

    const signature = create_signature(privateKey, genesisHash, chainId, substrateWallet.address);

    const hash = await api.tx.evmAccounts
      .claimAccount(evmAddress, signature)
      .signAndSend(substrateWallet);

    return hash;

  }
