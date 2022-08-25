"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendTx = void 0;
const handleTxResponse_1 = require("./handleTxResponse");
const sendTx = (api, extrinsic) => {
    return new Promise((resolve, reject) => {
        extrinsic
            .send((result) => {
            (0, handleTxResponse_1.handleTxResponse)(result, api)
                .then(({ result }) => {
                resolve(result);
            })
                .catch((err) => {
                reject(err);
            });
        })
            .catch((error) => {
            reject(error);
        });
    });
};
exports.sendTx = sendTx;
//# sourceMappingURL=sendTx.js.map