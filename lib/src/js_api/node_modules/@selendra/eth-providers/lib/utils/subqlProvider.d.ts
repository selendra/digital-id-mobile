import { Filter, FilterByBlockHash, Log } from '@ethersproject/abstract-provider';
import { Query, _Metadata, TransactionReceipt as TXReceiptGQL } from './gqlTypes';
export declare class SubqlProvider {
    readonly url: string;
    constructor(url: string);
    queryGraphql: (query: string) => Promise<Query>;
    getAllTxReceipts: () => Promise<TXReceiptGQL[]>;
    getTxReceiptByHash: (hash: string) => Promise<TXReceiptGQL | null>;
    getAllLogs: () => Promise<Log[]>;
    getFilteredLogs: (filter: Filter & FilterByBlockHash) => Promise<Log[]>;
    getIndexerMetadata: () => Promise<_Metadata>;
}
//# sourceMappingURL=subqlProvider.d.ts.map