"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.BlockCache = void 0;
class BlockCache {
    constructor(maxCachedBlocks = 200) {
        this._inspect = () => ({
            maxCachedBlocks: this.maxCachedBlocks,
            cachedBlocksCount: Object.keys(this.blockToHashes).length,
            cachedBlocks: Object.keys(this.blockToHashes),
            allBlockToHash: this.blockToHashes,
            allHashToBlock: this.hashToBlocks
        });
        this.blockToHashes = {};
        this.hashToBlocks = {};
        this.maxCachedBlocks = maxCachedBlocks;
    }
    // automatically preserve a sliding window of ${maxCachedBlocks} blocks
    addTxsAtBlock(blockNumber, txHashes) {
        txHashes.forEach((h) => (this.hashToBlocks[h] = blockNumber));
        this.blockToHashes[blockNumber] = txHashes;
        const cachedBlocksCount = Object.keys(this.blockToHashes).length;
        if (cachedBlocksCount > this.maxCachedBlocks) {
            const blockToRemove = Object.keys(this.blockToHashes)[0]; // assume insert order
            this._removeBlock(parseInt(blockToRemove));
        }
    }
    // if block exist in cache, remove it, otherwise do nothing
    _removeBlock(blockToRemove) {
        this.blockToHashes[blockToRemove]?.forEach((h) => delete this.hashToBlocks[h]);
        delete this.blockToHashes[blockToRemove];
    }
    getBlockNumber(hash) {
        return this.hashToBlocks[hash];
    }
}
exports.BlockCache = BlockCache;
//# sourceMappingURL=BlockCache.js.map