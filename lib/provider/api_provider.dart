import 'dart:convert';
import 'dart:math';
// import 'package:flutter_aes_ecb_pkcs5_fork/flutter_aes_ecb_pkcs5_fork.dart';
// import 'package:aes_ecb_pkcs5_flutter/aes_ecb_pkcs5_flutter.dart';
import 'package:digital_id/provider/contract_provider.dart';
import 'package:digital_id/services/db_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
// import 'package:defichaindart/defichaindart.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
// import 'package:polkawallet_sdk/kabob__sdk.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/utils/index.dart';
import 'package:http/http.dart' as http;
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:polkawallet_sdk/api/apiKeyring.dart';
import 'package:polkawallet_sdk/utils/localStorage.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/components/alert_dialog_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/models/account_m.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/provider/registration_p.dart';
import 'package:digital_id/services/apiKeyring.dart';
// import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:encrypt/encrypt.dart';
import 'package:digital_id/services/storage.dart';

class ApiProvider with ChangeNotifier {
  
  WalletSDK _sdk = WalletSDK();

  Keyring _keyring = Keyring();
  MyApiKeyring? _apiKeyring;

  Keyring get getKeyring => _keyring;
  WalletSDK get getSdk => _sdk;
  MyApiKeyring get apiKeyring => _apiKeyring!;
  
  String _defaultAddr = "5HnLfzCVR9vuM1z2fmZqsNazPqw6FzBJwr42HQRebmu6R4hH";

  // KeyringStorage _keyringStorage = KeyringStorage();
  // LocalStorage _storageOld = LocalStorage();
  // KeyringStorage _storage = KeyringStorage();

  static const int bitcoinDigit = 8;

  num bitcoinSatFmt = pow(10, 8);

  double amount = 0.0008;

  bool _isConnected = false;

  String btcAdd = '';

  // ContractProvider? contractProvider;

  AccountM accountM = AccountM();

  String? _jsCode;

  bool isMainnet = true;

  bool isDebug = false;
  
  int selNativeIndex = 0;
  int selV1Index = 1;
  int selV2Index = 2;
  int kgoIndex = 3;
  int ethIndex = 4;
  int bnbIndex = 5;
  int dotIndex = 6;
  int btcIndex = 7;
  int attIndex = 8;

  bool get isConnected => _isConnected;

  Future<void> initApi({@required BuildContext? context}) async {
    print("hello initApi");
    // contractProvider = Provider.of<ContractProvider>(context!, listen: false);

    // try {

      await rootBundle.loadString('lib/core/js_api/dist/main.js').then((String js) {
        _jsCode = js;
      });

      print("finish load main.js");
      await _keyring.init([0, 42]);
      print("finish init keyring");
      await _sdk.init(_keyring, jsCode: _jsCode);
      print("finish init sdk");
      _apiKeyring = MyApiKeyring(_sdk.api, _sdk.api.keyring.service!);
      // await connectNode(context: context);

    // } catch (e) {
    //   // print("Error initApi $e");
    // }
  }

  // Future<NetworkParams> connectPolNon({@required BuildContext? context}) async {
  //   dynamic res;
  //   try {

  //     final node = NetworkParams();
  //     node.name = 'Polkadot(Live, hosted by PatractLabs)';
  //     node.endpoint = isMainnet ? AppConfig.networkList[1].wsUrlMN : AppConfig.networkList[1].wsUrlTN;//'wss://westend-rpc.polkadot.io';//'wss://polkadot.elara.patract.io';//AppConfig.networkList[1].wsUrlMN; ;
  //     node.ss58 = 0;

  //     // final node = NetworkParams();
  //     // node.name = 'Polkadot(Live, hosted by PatractLabs)';
  //     // node.endpoint = 'wss://polkadot.elara.patract.io';
  //     // node.ss58 = 0;

  //     res = await _sdk.api.connectNode(_keyring, [node]);

  //     await getDotChainDecimal(context: context!);

  //     notifyListeners();
  //   } catch (e) {
  //     // print("Error connectPolNon $e");
  //   }

  //   return res ?? NetworkParams();
  // }

  Future<bool> validateBtcAddr(String address) async {
    // return Address.validateAddress(address, bitcoin);
    return false;
  }

  void setBtcAddr(String btcAddress) {
    btcAdd = btcAddress;
    notifyListeners();
  }

  Future<String> calBtcMaxGas() async {
    
    // int input = 0;

    // final from = await StorageServices.fetchData(DbKey.bech32);

    // final txb = TransactionBuilder();
    // txb.setVersion(1);
    // final res = await getAddressUxto(from);

    // if (res.length != 0) {
    //   for (final i in res) {
    //     if (i['status']['confirmed'] == true) {
    //       txb.addInput(i['txid'], int.parse(i['vout'].toString()), null);
    //       input++;
    //     }
    //   }
    // }

    // final trxSize = calTrxSize(input, 2);

    // return trxSize.toString();
    return '';
  }

  Future<int> sendTxBtc(BuildContext context, String from, String to, double amount, String wif) async {
    // int totalSatoshi = 0;
    // int input = 0;
    // final alice = ECPair.fromWIF(wif);

    // final p2wpkh = new P2WPKH(data: new PaymentData(pubkey: alice.publicKey)).data;

    // final txb = TransactionBuilder();
    
    // txb.setVersion(1);

    // final res = await getAddressUxto(from);

    // if (res.length != 0) {
    //   for (final i in res) {
    //     if (i['status']['confirmed'] == true) {
    //       txb.addInput(i['txid'], int.parse(i['vout'].toString()), null, p2wpkh!.output);
    //       totalSatoshi += int.parse(i['value'].toString());
    //       input++;
    //     }
    //   }
    // }

    // final totaltoSend = (amount * bitcoinSatFmt).floor();

    // if (totalSatoshi < totaltoSend) {
    //   await customDialog(context, 'You do not have enough in your wallet to send that much.', 'Opps');
    // }

    // final fee = calTrxSize(input, 2) * 88;

    // if (fee > (amount * bitcoinSatFmt).floor()) {
    //   await customDialog(
    //     context,
    //     "BitCoin amount must be larger than the fee. (Ideally it should be MUCH larger)",
    //     'Opps'
    //   );
    // }

    // final change = totalSatoshi - ((amount * bitcoinSatFmt).floor() + fee);

    // txb.addOutput(to, totaltoSend);
    // txb.addOutput(from, change);

    // for (int i = 0; i < input; i++) {
    //   txb.sign(vin: i, keyPair: alice);
    // }

    // final response = await pushTx(txb.build().toHex());

    // return response;
    return 0;
  }

  Future<void> customDialog(BuildContext context, String text1, String text2) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Align(
            child: Text(text1),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text(text2),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<int> pushTx(String hex) async {
    final res = await http.post(Uri.parse('https://api.smartbit.com.au/v1/blockchain/pushtx'),
      //headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: json.encode({"hex": hex}));
    return res.statusCode;
  }

  int calTrxSize(int nInput, int nOutput) {
    return nInput * 180 + nOutput * 34 + 10 + nInput;
  }

  Future<dynamic> getAddressUxto(String address) async {
    try {

      final res = await http.get(Uri.parse('https://blockstream.info/api/address/$address/utxo'));

      return jsonDecode(res.body);
    } catch (e){
      // print("Err getAddressUxto $e");
    }
  }

  Future<void> getBtcBalance({@required BuildContext? context}) async {
    // final contract = await Provider.of<ContractProvider>(context!, listen: false);
    // try {
    //   int totalSatoshi = 0;
    //   final res = await getAddressUxto(contract.listContract[btcIndex].address!);

    //   if (res.length == 0) {
    //     contract.listContract[btcIndex].balance = '0';
    //   } else {
    //     for (final i in res) {
    //       if (i['status']['confirmed'] == true) {
    //         totalSatoshi += int.parse(i['value'].toString());
    //       }
    //     }

    //     contract.listContract[btcIndex].balance = (totalSatoshi / bitcoinSatFmt).toString();
    //   }

    //   contract.listContract[btcIndex].lineChartModel = LineChartModel().prepareGraphChart(contract.listContract[btcIndex]);

    //   notifyListeners();
    // } catch (e) {
    //   // print("Err getBtcBalance $e");
    // }
  }

  void isBtcAvailable(String? contain, {@required BuildContext? context}) {
    // final con = Provider.of<ContractProvider>(context!, listen: false);
    // if (contain != null) {
    //   con.listContract[btcIndex].isContain = true;
    //   notifyListeners();
    // }
  }

  // Future<void> setBtcMarket(Market marketData, List<List<double>> lineChartData, String currentPrice, String priceChange24h, {@required BuildContext? context}) async {

  //   // btc.marketData = marketData;
  //   // btc.marketPrice = currentPrice;
  //   // btc.change24h = priceChange24h;
  //   // btc.lineChartList = lineChartData ?? [];

  //   // final contract = await Provider.of<ContractProvider>(context!, listen: false);
  //   // contract.listContract[btcIndex].marketData = marketData;
  //   // contract.listContract[btcIndex].marketPrice = currentPrice;
  //   // contract.listContract[btcIndex].change24h = priceChange24h;
  //   // contract.listContract[btcIndex].lineChartList = lineChartData;
  //   // notifyListeners();
  // }

  // void dotIsNotContain() {
  //   dot.isContain = false;
  //   notifyListeners();
  // }
  Future<bool>? validateMnemonic(String mnemonic) async {

    dynamic res;
    try {

      res = await _sdk.api.service.webView!.evalJavascript('keyring.validateMnemonic("$mnemonic")');
      print("validate mnemonic $res");
      return res;
    } catch (e) {
      // print("Error validateMnemonic $e");
    }
    return res ?? false;
  }
  
  Future<bool> validateEther(String address) async {
    try {

      dynamic res = await _sdk.api.service.webView!.evalJavascript('wallets.validateEtherAddr("$address")');
      return res;
    } catch (e) {
      // print("Error validateEther $e");
    }
    return false;
  }

  Future<String> getPrivateKey(String mnemonic) async {
    try {

      final res = await _sdk.api.service.webView!.evalJavascript("wallets.getPrivateKey('$mnemonic')");//ApiProvider._sdk.api.getPrivateKey(mnemonic);
      return res;
    } catch (e) {
      // print("Error getPrivateKey $e");
    }
    return '';
  }

  Future<bool> validateAddress(String address) async {
    try {

      final res = await _sdk.api.service.webView!.evalJavascript("keyring.validateAddress('$address')");
      return res;
    } catch (e) {
      // print("Error validateAddress $e");
    }
    return false;
  }

  Future<NetworkParams?> connectSELNode({@required BuildContext? context, String? funcName = 'keyring'}) async {
    print("connectSELNode");
    try {

      NetworkParams node = NetworkParams();
      NetworkParams? res = NetworkParams();

      node.name = 'Indranet hosted By Selendra';
      node.endpoint = isMainnet ? AppConfig.networkList[0].wsUrlMN : AppConfig.networkList[0].wsUrlTN;
      node.ss58 = isMainnet ? AppConfig.networkList[0].ss58MN : AppConfig.networkList[0].ss58;

      await _sdk.api.connectNode(_keyring, [node]).then((value) async {
        res = value;
        if (getKeyring.keyPairs.isNotEmpty) await getSelNativeChainDecimal(context: context, funcName: funcName);
      });

      // final res = await _sdk.webView!.evalJavascript("settings.connect(${jsonEncode([node].map((e) => e.endpoint).toList())})");

      // if (res != null) 

      return res;
    } catch (e) {
      if (ApiProvider().isDebug == true) print("Error connectSELNode $e");
    }
    return null;
  }

  Future<void> getSelNativeChainDecimal({@required BuildContext? context, String? funcName = 'keyring'}) async {
    print("getSelNativeChainDecimal");
    try {
      dynamic res;
      
      ContractProvider contract = Provider.of<ContractProvider>(context!, listen: false);
      
      // await querySELAddress().then((value) async {
      //   await _sdk.api.service.webView!.evalJavascript('settings.getChainDecimal(api)').then((value) async {
          
      //     res = value;
      //     contract.listContract[selNativeIndex].chainDecimal = res[0].toString();
      //     await subSELNativeBalance(context: context);

      //     notifyListeners();
      //   });
      // });
    } catch (e) {
      if (ApiProvider().isDebug == true) print("Error getChainDecimal $e");
    }
  }

  // Future<NetworkParams?> connectNode({@required BuildContext? context}) async {
  //   print("connectNode");
  //   try {

  //     final node = NetworkParams();

  //     // node.name = 'Indranet hosted By Seslendra';
  //     node.endpoint = 'wss://student.selendra.org';//'wss://10.1.1.117:9944';//isMainnet ? AppConfig.networkList[0].wsUrlMN : AppConfig.networkList[0].wsUrlTN;
  //     node.ss58 = 42;//isMainnet ? AppConfig.networkList[0].ss58MN : AppConfig.networkList[0].ss58;

  //     // node.endpoint = 'wss://rpc1-mainnet.selendra.org/';//isMainnet ? AppConfig.networkList[0].wsUrlMN : AppConfig.networkList[0].wsUrlTN;
  //     // node.ss58 = 972;//isMainnet ? AppConfig.networkList[0].ss58MN : AppConfig.networkList[0].ss58;

  //     final res = await _sdk.api.connectNode(_keyring, [node]).then((value) async {
  //       // await addAcc(context: context);
  //       // Check If Not Yet Login Not Allow To Auto Gernate Account
  //       await StorageServices.fetchData(DbKey.login).then((login) async {
  //         await StorageServices.fetchData(DbKey.sensitive).then((sensitive) async {
  //           if (value == null && sensitive == null && _keyring.allAccounts.isEmpty){
  //             await autoGenerateAcc(context: context);
  //           }
  //         });
  //       });
  //     });

  //     // final res = await _sdk.webView!.evalJavascript("settings.connect(${jsonEncode([node].map((e) => e.endpoint).toList())})");

  //     // if (res != null) 

  //     notifyListeners();

  //     return res;
  //   } catch (e) {
  //     // print("Error connectSELNode $e");
  //   }
  //   return null;
  // }

  // Future<void> autoGenerateAcc({BuildContext? context}) async {
  //   print("autoGenerateAcc");

  //   try {

  //     String _seed = await Provider.of<ApiProvider>(context!, listen: false).generateMnemonic();
  //     print("_Seed $_seed");
  //     RegistrationProvider _registration = Provider.of<RegistrationProvider>(context, listen: false);
  //     await Provider.of<ApiProvider>(context, listen: false).addAcc(context: context, usrName: _registration.usrName ?? '', password: "1234", seed: _seed).then((value) async {
  //       await encryptData(context: context, seed: _seed);
  //     });
  //   } catch (e){
  //     print("Error autoGenerateAcc $e");
  //   }

  // }

  // Future<void> encryptData({required BuildContext? context, String? seed = ''}) async {

  //   RegistrationProvider _registration = Provider.of<RegistrationProvider>(context!, listen: false);

  //   await getCurrentAccount().then((value) async {
      
  //     // Encode Data
  //     Map<String, dynamic>? map = {
  //       'name': _registration.usrName ?? '',
  //       'email': _registration.email,
  //       'password': _registration.password,
  //       'seed': seed,
  //       'pr_key': accountM.pubKey
  //     };
      
  //     // Encrypt Data
  //     Encrypted _encrypted = Encryption().encryptAES(json.encode(map));
  //     await StorageServices.storeData(_encrypted.bytes, DbKey.sensitive);
  //     // Make Web3 account Link with Email Address
  //     await createWeb3linkSel(email: _registration.email);
  //   });
  // }

  Future<void> scanQr(String id, {BuildContext? context}) async {
    // id = id.replaceAll('"', "");
    print("scanQr $id");

    try {

      HomeProvider _provider = Provider.of<HomeProvider>(context!, listen: false);


      await _provider.connectWS(id, context: context);
      // await query(email: id).then((value) async {
      //   print("query value $value");
      //   if(value['accountId'] == _provider.homeModel.wallet){
      //   } else {
      //     await MyDialog().customDialog(context, "Oops", "Something went wrong!");
      //   }
      // });


      
      // _sdk.api.service.webView!.evalJavascript('keyring.simulateScan("$id")').then((value) async {
      //   print("scanQr $value");
      //   print(value['status']);
        
      //   return value;
      // });

    } catch (e){
      print("Error registerSELNetwork ${e}");
    }

  }

  Future<void> addAcc({@required BuildContext? context, required String? usrName, required String? password, required String? seed}) async {
    print("addAcc");

    print("Seed $seed");
    print("usrName $usrName");
    print("password $password");

    dynamic json = await apiKeyring.importAccount(
      _keyring,
      keyType: KeyType.mnemonic,
      key: seed!,
      name: usrName!,
      password: password!,
    );

    print("finish importAccount");

    await apiKeyring.addAccount(
      _keyring,
      keyType: KeyType.mnemonic,
      acc: json,
      password: password,
    ).then((value) {
      print("addAccount $value");
    });
  }

  // Connect SEL Chain
  Future<void> getChainDecimal({@required BuildContext? context}) async {
    print("getChainDecimal");
    print("_keyring.current.pubKey ${_keyring.current.pubKey}");
    try {
      

      final res = await _sdk.api.service.webView!.evalJavascript('settings.getChainDecimal(api)');
      print("res $res");
      // await _sdk.api.service.webView!.evalJavascript('keyring.registerSel11(api, "pojih13049@ishop2k.com","12345", "${_keyring.current.pubKey}")').then((value) {
      //   print("change Password Sel13 $value");
      // });
      // contract.listContract[selNativeIndex].chainDecimal = res[0].toString();
      // await subSELNativeBalance(context: context);

      notifyListeners();
    } catch (e) {
      // print("Error getChainDecimal $e");
    }
  }

  Future<dynamic> loginSELNetwork({required String? email, required String? password}) async {
    try {

      return await _sdk.api.service.webView!.evalJavascript('keyring.loginAccessSel12(api, "$email","$password")');

    } catch (e){
      print("Error registerSELNetwork ${e}");
    }
    return false;
  }

  Future<dynamic> registerSELNetwork({required String? email, required String? password}) async {
    try {

      return await _sdk.api.service.webView!.evalJavascript('keyring.registerSel11(api, "$email","$password")').then((value) async {
        print("registerSel11 $value");
        print(value['status']);

        // Set Referal code to Email AFter Register
        await setReferalSel12(email: email);
        return value;
      });

    } catch (e){
      print("Error registerSELNetwork ${e}");
    }
  }

  Future<dynamic> query({required String? email}) async {
    try {

      return await _sdk.api.service.webView!.evalJavascript('keyring.queryData(api, "$email", "123456")').then((value) async { // api, "$email", "5FLfHZwYbAoJdLmy1KBjMmKNy2fsCQ6858dmpaGXrHn5G2vV"
        print("my queryData $value");
        print(value['accountId']);
        return value;
      });

    } catch (e){
      print("Error queryData ${e}");
    }
  }

  Future<dynamic> queryByAddr({required String? addr}) async {
    try {

      return await _sdk.api.service.webView!.evalJavascript('keyring.queryDataByAddr(api, "$addr")').then((value) async { // api, "$email", "5FLfHZwYbAoJdLmy1KBjMmKNy2fsCQ6858dmpaGXrHn5G2vV"
        print("my queryData $value");
        print(value['accountId']);
        return value;
      });

    } catch (e){
      print("Error queryData ${e}");
    }
  }

  Future<dynamic> setReferalSel12({required String? email}) async {
    print("setReferalSel12");
    try {

      return await _sdk.api.service.webView!.evalJavascript('keyring.setReferalSel12(api, "$email")').then((value) async {
        print("setReferalSel12 $value");
        print(value['status']);
        return value;
      });

    } catch (e){
      print("Error registerSELNetwork ${e}");
    }
  }

  /// For Referal Code Already Pass Inside The Function
  Future<dynamic> createWeb3linkSel({required String? email}) async {
    print("createWeb3linkSel15");
    try {

      return await _sdk.api.service.webView!.evalJavascript('keyring.createWeb3linkSel(api, "$email", "${accountM.address}")').then((value) async { // api, "$email", "5FLfHZwYbAoJdLmy1KBjMmKNy2fsCQ6858dmpaGXrHn5G2vV"
        print("registerSel11 $value");
        print(value['status']);
        return value;
      });

    } catch (e){
      print("Error registerSELNetwork ${e}");
    }
  }

  Future<dynamic> transfer() async {
    print("createWeb3linkSel15");
    try {

      return await _sdk.api.service.webView!.evalJavascript('keyring.transfer(api, "5FLfHZwYbAoJdLmy1KBjMmKNy2fsCQ6858dmpaGXrHn5G2vV")').then((value) async {
        print("registerSel11 $value");
        print(value['status']);
        return value;
      });

    } catch (e){
      print("Error registerSELNetwork ${e}");
    }
  }

  Future<void> subSELNativeBalance({@required BuildContext? context}) async {
    // print("subSELNativeBalance");
    // try {

    //   final contract = Provider.of<ContractProvider>(context!, listen: false);
    //   print("${contract.listContract[selNativeIndex].address}");
    //   await _sdk.webView!.evalJavascript("account.getBalance(api, '${contract.listContract[selNativeIndex].address}', 'Balance')").then((value) {
    //     contract.listContract[selNativeIndex].balance = Fmt.balance(
    //       value['freeBalance'].toString(),
    //       int.parse(contract.listContract[selNativeIndex].chainDecimal!),
    //     );
    //   });
      // await _sdk.api.account.subscribeBalance(contract.listContract[0].address, (res) {
    //   //   print("Res $res");
    //   //   contract.listContract[0].balance = Fmt.balance(
    //   //     res.freeBalance.toString(),
    //   //     int.parse(contract.listContract[0].chainDecimal!),
    //   //   );

    //   //   notifyListeners();
    //   // });
    //   Provider.of<ContractProvider>(context, listen: false).setSELNativeAddr(contract.listContract[0].address!);
    // } catch (e) {
    //   // print("Error subscribeSELBalance $e");
    // }
  }

  void isDotContain({@required BuildContext? context}) {
    // final con = Provider.of<ContractProvider>(context!, listen: false);
    // con.listContract[dotIndex].isContain = true;
    // notifyListeners();
  }

  // Future<void> setDotMarket(Market marketData, List<List<double>> lineChartData, String currentPrice, String priceChange24h, {@required BuildContext? context}) async {

  //   final contract = await Provider.of<ContractProvider>(context!, listen: false);
  //   contract.listContract[dotIndex].marketData = marketData;
  //   contract.listContract[dotIndex].marketPrice = currentPrice;
  //   contract.listContract[dotIndex].change24h = priceChange24h;
  //   contract.listContract[dotIndex].lineChartList = lineChartData;

  //   notifyListeners();
  // }

  Future<void> getDotChainDecimal({@required BuildContext? context}) async {
    // try {
    //   final contract = await Provider.of<ContractProvider>(context!, listen: false);
    //   final res = await _sdk.api.service.webView!.evalJavascript('settings.getChainDecimal(api)');
    //   contract.setDotAddr(_keyring.allAccounts[0].address!, res[0].toString());

    //   await subscribeDotBalance(context: context);

    //   notifyListeners();
    // } catch (e) {
    //   // print("Err getDotChainDecimal $e");
    // }
  }

  Future<void> subscribeDotBalance({@required BuildContext? context}) async {
    // try {

    //   final contract = await Provider.of<ContractProvider>(context!, listen: false);
    //   // final msgChannel = 'NBalance';
    //   // final code = 'account.getBalance(api, "${_keyring.current.address}", "$msgChannel")';

    //   await _sdk.api.account.subscribeBalance(_keyring.current.address, (res){

    //     contract.listContract[dotIndex].balance = Fmt.balance(
    //       res.freeBalance.toString(),
    //       int.parse(contract.listContract[dotIndex].chainDecimal!),
    //     );

    //     contract.listContract[dotIndex].lineChartModel = LineChartModel().prepareGraphChart(contract.listContract[dotIndex]);
    //     notifyListeners();
    //   });
      
    // } catch (e) {
    //   // print("Error subscribeDotBalance $e");
    // }
  }

  Future<void> getAddressIcon() async {
    print("getAddressIcon");
    try {

      final res = await _sdk.api.account.getPubKeyIcons(
        [_keyring.keyPairs[0].pubKey!],
      );

      print("res ${res}");
      print("res2 ${res![0][0]}");

      accountM.addressIcon = res.toString();
      accountM.address = res[0][0].toString();
      accountM.pubKey = _keyring.keyPairs[0].pubKey!;
      notifyListeners();
    } catch (e) {
      print("Error get icon from address $e");
    }
  }

  Future<void> getCurrentAccount({String funcName = 'account'}) async {
    print("getCurrentAccount");
    try {

      accountM.address = await _sdk.webView!.evalJavascript('$funcName.getSELAddr()');
      accountM.name = _keyring.current.name;
      print("accountM.address ${accountM.address}");
      print("accountM.name ${accountM.name}");
      // contractProvider!.setSELNativeAddr(accountM.address!);
    } catch (e){
      // print("Error getCurrentAccount $e");
    }
    
    notifyListeners();
  }

  Future<List> getCheckInList(String attender) async {
    final res = await _sdk.api.service.webView!.evalJavascript('settings.getCheckInList(aContract,"$attender")');
    return res;
  }

  Future<List> getCheckOutList(String attender) async {
    final res = await _sdk.api.service.webView!.evalJavascript('settings.getCheckOutList(aContract,"$attender")');
    return res;
  }

  Future<String> decryptPrivateKey(String privateKey, String password) async {
    final String key = Encrypt.passwordToEncryptKey(password);
    final String? decryted = await FlutterAesEcbPkcs5.decryptString(privateKey, key);
    return decryted!;
  }

  Future<String> encryptPrivateKey(String privateKey, String password) async {
    print("encryptPrivateKey");
    try {

      final String key = Encrypt.passwordToEncryptKey(password);
      final String? encryted = await FlutterAesEcbPkcs5.encryptString(privateKey, key);
      print("Data encrypt $encryted");
      return encryted!;
    } catch (e) {
      // print("Error encryptPrivateKey $e");
    }
    return '';
  }

  Future<Map> signAndSendDot(Map txInfo, String params, password, Function(String) onStatusChange) async {
    final msgId = "onStatusChange${_sdk.webView!.getEvalJavascriptUID()}";
    _sdk.webView!.addMsgHandler(msgId, onStatusChange);
    final code = '_keyring.sendTx(apiNon, ${jsonEncode(txInfo)}, $params, "$password", "$msgId")';

    final Map res = await _sdk.webView!.evalJavascript(code);
    _sdk.webView!.removeMsgHandler(msgId);

    return res;
  }

  /// Generate a set of new mnemonic.
  Future<String> generateMnemonic() async {
    print("generateMnemonic");
    final Map<String, dynamic> acc = await _sdk.webView!.evalJavascript('keyring.gen()');
    print("acc['mnemonic'] ${acc['mnemonic']}");
    return acc['mnemonic'];
  }

  Future<KeyPairData> addAccount(
    Keyring keyring, {
    required KeyType keyType,
    required Map acc,
    required String password,
  }) async {
    print("Hey addAccount");
    // save seed and remove it before add account
    // if (keyType == KeyType.mnemonic || keyType == KeyType.rawSeed) {
    // }
      print("acc $acc");
      print("addAccount");
      final String type = keyType.toString().split('.')[1];
      print("type $type");
      final String? seed = acc[type];
      print("seed $seed");
      if (seed != null && seed.isNotEmpty) {
        await encryptSeedAndSave(acc['pubKey'], acc[type], type, password);
        acc.remove(type);
      }

    // save keystore to storage
    await keyring.store.addAccount(acc);

    return KeyPairData.fromJson(acc as Map<String, dynamic>);
  }

  Future<void> encryptSeedAndSave(String? pubKey, seed, seedType, password) async {
    // print("encryptSeedAndSave");
    // final String key = Encrypt.passwordToEncryptKey(password);
    // final String encrypted = await FlutterAesEcbPkcs5.encryptString(seed, key);
    // print("encrypted $encrypted");

    // // read old data from storage-old
    // dynamic stored = await _storageOld.getSeeds(seedType);
    // stored[pubKey] = encrypted;
    // print("stored[pubKey] $stored");
    // // and save to new storage
    // if (seedType == KeyType.mnemonic.toString().split('.')[1]) {
    //   final mnemonics = Map.from(_storage.encryptedMnemonics.val);
    //   mnemonics.addAll(stored);
    //   _storage.encryptedMnemonics.val = mnemonics;
    //   print(_storage.encryptedMnemonics.val);
    //   return;
    // }
    // if (seedType == KeyType.rawSeed.toString().split('.')[1]) {
    //   final seeds = Map.from(_storage.encryptedRawSeeds.val);
    //   seeds.addAll(stored);
    //   _storage.encryptedRawSeeds.val = seeds;
    // }
  }

  Future<Map<String, dynamic>?> getDecryptedSeed(String? pubKey, password) async {
  //   print("getDecryptedSeed");
  //   print(_storage.encryptedMnemonics.val[pubKey]);
  //   final key = Encrypt.passwordToEncryptKey(password);
  //   final mnemonic = _storage.encryptedMnemonics.val[pubKey];
  //   if (mnemonic != null) {
  //     final res = {'type': KeyType.mnemonic.toString().split('.')[1]};
  //     try {
  //       res['seed'] = await FlutterAesEcbPkcs5.decryptString(mnemonic, key);
  //     } catch (err) {
  //       print(err);
  //     }
  //     return res;
  //   }
  //   final rawSeed = _storage.encryptedRawSeeds.val[pubKey];
  //   if (rawSeed != null) {
  //     final res = {'type': KeyType.rawSeed.toString().split('.')[1]};
  //     try {
  //       res['seed'] = await FlutterAesEcbPkcs5.decryptString(rawSeed, key);
  //     } catch (err) {
  //       print(err);
  //     }
  //     return res;
  //   }
  //   return null;
  }
}
