import { Filter, Log } from '@ethersproject/abstract-provider';
import { Log as LogGQL } from './gqlTypes';
export declare type TopicsFilter = (string | string[] | null)[] | undefined;
export declare type AddressFilter = string | string[] | undefined;
export interface SubscriptionLogFilter {
    address?: string | string[];
    topics?: TopicsFilter;
}
export declare const filterLogByTopics: (log: Log, topics: TopicsFilter) => boolean;
export declare const filterLogByAddress: (log: Log, targetAddr: AddressFilter) => boolean;
export declare const filterLog: (log: Log, filter: SubscriptionLogFilter) => boolean;
export declare const getLogsQueryFilter: (filter: Filter) => string;
export declare const adaptLogs: (logs: LogGQL[]) => Log[];
export declare const LOGS_NODES = "\n  nodes {\n    blockNumber,\n    blockHash,\n    transactionIndex,\n    removed,\n    address,\n    data,\n    topics,\n    transactionHash,\n    logIndex,\n  }\n";
export declare const TX_RECEIPT_NODES: string;
//# sourceMappingURL=logs.d.ts.map