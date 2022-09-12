export interface HashToBlockMap {
    [hash: string]: number;
}
export interface BlockToHashesMap {
    [block: string]: string[];
}
export interface CacheInspect {
    maxCachedBlocks: number;
    cachedBlocksCount: number;
    cachedBlocks: string[];
    allBlockToHash: Record<string, string[]>;
    allHashToBlock: Record<string, number>;
}
export declare class BlockCache {
    blockToHashes: BlockToHashesMap;
    hashToBlocks: HashToBlockMap;
    maxCachedBlocks: number;
    constructor(maxCachedBlocks?: number);
    addTxsAtBlock(blockNumber: number, txHashes: string[]): void;
    _removeBlock(blockToRemove: number): void;
    getBlockNumber(hash: string): number | undefined;
    _inspect: () => CacheInspect;
}
//# sourceMappingURL=BlockCache.d.ts.map