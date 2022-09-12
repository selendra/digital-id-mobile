import { verifyTypedData } from '@ethersproject/wallet';
import { createTransactionPayload } from './createTransactionPayload';
import { SelendraEvmTXPayload } from './types';

export const verifyTransaction = (tx: SelendraEvmTXPayload, signature: string): string => {
  const payload = createTransactionPayload(tx);

  return verifyTypedData(
    payload.domain,
    {
      AccessList: payload.types.AccessList,
      Transaction: payload.types.Transaction
    },
    payload.message,
    signature
  );
};
