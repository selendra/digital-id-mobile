import 'dart:async';
import 'package:digital_id/models/trx_info.dart';
import 'package:web3dart/web3dart.dart';

abstract class INativeService {
  Future<Credentials>? getCredentials(String privateKey);
  Future<num>? getBalance(EthereumAddress from);
  Future<BigInt>? getMaxGas(EthereumAddress sender, TransactionInfo trxInfo);
  Future<bool>? listenTransfer(String hash);
  Future<String>? sendTx(TransactionInfo trxInfo);
  Future<void>? dispose();
}
