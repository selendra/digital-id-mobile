import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:wallet_apps/src/components/dialog_c.dart';
import 'package:wallet_apps/src/constants/db_key_con.dart';
import 'package:wallet_apps/src/models/account.m.dart';
import 'package:wallet_apps/src/screen/home/menu/account/body_acc.dart';
import '../../../../../index.dart';

class Account extends StatefulWidget {
  //static const route = '/account';
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  AccountM _accountModel = AccountM();

  ApiProvider? _apiProvider;

  bool? isBindAcc = false;

  String onChanged(String value) {
    _accountModel.backupKey.currentState!.validate();
    return value;
  }

  String onChangedChangePin(String value) {
    _accountModel.changePinKey.currentState!.validate();
    return value;
  }

  String onChangedBackup(String value) {
    _accountModel.backupKey.currentState!.validate();
    return value;
  }

  Future<void> onSubmit() async {
    if (_accountModel.backupKey.currentState!.validate()) {
      await getBackupKey(_accountModel.pinController.text);
    }
  }


  Future<void> submitBackUpKey() async {
    if (_accountModel.pinController.text.isNotEmpty) {
      await getBackupKey(_accountModel.pinController.text);
    }
  }
  

  Future<void> deleteAccout() async {
    await customDialog(
      context, 
      'Log Out account', 
      'Are you sure to log out your account?',
      btn2: TextButton(
        onPressed: () async => await _deleteAccount(),
        child: MyText(
          text: 'Delete',
          color: AppColors.redColor,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }

  Future<void> _deleteAccount() async {

    dialogLoading(context);

    final _api = await Provider.of<ApiProvider>(context, listen: false);

    print("_accountModel._api.getKeyring.current! ${_api.getKeyring.current}");
    
    try {
      await _api.apiKeyring.deleteAccount(
        _api.getKeyring,
        _api.getKeyring.current,
      );

      final mode = await StorageServices.fetchData(DbKey.themeMode);
      // final event = await StorageServices.fetchData(DbKey.event);

      await StorageServices().clearStorage();

      // Re-Save Them Mode
      await StorageServices.storeData(mode, DbKey.themeMode);
      // await StorageServices.storeData(event, DbKey.event);

      await StorageServices().clearSecure();
      
      Provider.of<ContractProvider>(context, listen: false).resetConObject();

      await Future.delayed(Duration(seconds: 2), () {});
      
      Provider.of<WalletProvider>(context, listen: false).clearPortfolio();

      Navigator.pushAndRemoveUntil(context, RouteAnimation(enterPage: Welcome()), ModalRoute.withName('/'));
    } catch (e) {
      if (ApiProvider().isDebug == true) print("_deleteAccount ${e.toString()}");
      // await dialog(context, e.toString(), 'Opps');
    }
  }

  Future<void> getBackupKey(String pass) async {

    Navigator.pop(context);
    final _api = await Provider.of<ApiProvider>(context, listen: false);
    try {
      // final pairs = await KeyringPrivateStore([0, 42])// (_api.getKeyring.keyPairs[0].pubKey, pass);
      final pairs = await KeyringPrivateStore([_api.isMainnet ? AppConfig.networkList[0].ss58MN! : AppConfig.networkList[0].ss58!]).getDecryptedSeed(_api.getKeyring.keyPairs[0].pubKey, pass);
      if (pairs!['seed'] != null) {
        print("pairs['seed'] ${pairs['seed']}");
        await customDialog(context, 'Backup Key', pairs['seed'].toString());
      } else {
        await customDialog(context, 'Backup Key', 'Incorrect Pin');
      }
    } catch (e) {
      //await dialog(context, e.toString(), 'Opps');
      if (ApiProvider().isDebug == true) print("Error getBackupKey $e");
    }
    _accountModel.pinController.text = '';
  }

  Future<void> _changeName() async {
    dialogLoading(context);
    if (_accountModel.editNameController.text.isNotEmpty){
      dialogLoading(context);
      final api = await Provider.of<ApiProvider>(context, listen: false);
      final changePass = await api.apiKeyring.changeName(api.getKeyring, _accountModel.editNameController.text);
      String funcName = "account";
      await api.getAddressIcon();
      while(true){
        print("funcName $funcName");
        await api.getCurrentAccount(context: context, funcName: funcName);
        if (api.accountM.address != null) break;
        else funcName = 'keyring';
      }

      Navigator.pop(context);
      if (changePass != null) {
        await customDialog(context, 'Change Name', 'You name has changed!!!');
      } else {
        await customDialog(context, 'Oops', 'Change Failed!!!');
      }

      _accountModel.editNameController.text = '';
      // Close Dialog
      Navigator.pop(context);
    }
  }

  void copyToClipBoard(String text, BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    ).then(
      (value) => {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Copied to Clipboard'),
          duration: Duration(seconds: 3),
        )),
      },
    );
  }

  void onSubmitName() {

  }

  void onChangeName() {
    
  }

  Future<void> submitChangePin() async {
    // if (_accountModel.oldPassController.text.isNotEmpty && _accountModel.newPassController.text.isNotEmpty) {
    //   await _changePin(_accountModel.oldPassController.text, _accountModel.newPassController.text);
    // }
  }

  Future<void> _changePin() async {

    // setState(() {
    //   _accountModel.loading = true;
    // });
    dialogLoading(context);
    final res = await Provider.of<ApiProvider>(context, listen: false);
    await res.apiKeyring.checkPassword(res.getKeyring.keyPairs[0], _accountModel.oldPinController.text).then((value) {
      print("checkPassword $value");
    });
    final changePass = await res.apiKeyring.changePassword(res.getKeyring, _accountModel.oldPinController.text, _accountModel.newPinController.text);
    if (changePass != null) {
      await customDialog(context, 'Change Pin', 'You pin has changed!!!');
    } else {

      await customDialog(context, 'Opps', 'Change Failed!!!');
    }

    // Close Dialog
    Navigator.pop(context);
    // _accountModel.oldPassController.text = '';
    // _accountModel.newPassController.text = '';
    // _accountModel.oldNode.requestFocus();
  }

  checkBindAcc() async {
    print("checkBindAcc");
    await StorageServices.fetchData(DbKey.bindAcc).then((value) {
      print("value ${value.toString()}");
      if (value != null){
        print(value['error'].toString() == "Account already exit, please use new evm account");
        if ( (value['error'].toString() == "Account already exit, please use new evm account") || value.containsKey("hash")){

          isBindAcc = true;
        }
      }
    });
    setState(() {
      
    });
  }

  Future<void> bindAcc() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => Passcode(label: PassCodeLabel.fromMint))).then((value) async {
      print("formBackUp $value");
      
      dialogLoading(context, content: "Binding account");

      if (value != null){
        await _apiProvider!.apiKeyring.getDecryptedSeed(_apiProvider!.getKeyring, value).then((seeds) async {
          print("seed ${seeds!.seed}");
          final pk = await _apiProvider!.getPrivateKey(seeds.seed!);
          print("pk $pk");
          await _apiProvider!.getSdk.webView!.evalJavascript("accBinding.bindAccount('${seeds.seed!}', '$pk', '${ ApiProvider().isMainnet ? AppConfig.networkList[0].wsUrlMN : AppConfig.networkList[0].wsUrlTN}', '${ ApiProvider().isMainnet ? AppConfig.networkList[0].wsUrlMN : AppConfig.networkList[0].wsUrlTN}' )").then((result) async {
            print("result['status'] == false ${result['status'] == false}");
            
            // Close Dialog
            Navigator.pop(context);

            if (result['status'] == false){
              if (result['error'].toString() != "Account already exit, please use new evm account"){
                await DialogComponents().dialogCustom(context: context, contents: "Account bind failed", titles: "Oops");
              }
            } else {
              await StorageServices.storeData(result, DbKey.bindAcc);
            }
          });
        });
      } else {

        // Close Dialog
        Navigator.pop(context);
      }
    });

    setState(() {
      
    });
  }

  @override
  void initState() {
    isBindAcc = false;
    _apiProvider = Provider.of<ApiProvider>(context, listen: false);
    checkBindAcc();
    
    // _accountModel.currentAcc = Provider.of<ApiProvider>(context, listen: false).getKeyring.keyPairs[0];
    // _accountModel.editNameController.text = Provider.of<ApiProvider>(context, listen: false).accountM.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AccountBody(
      accountModel: _accountModel,
      onSubmitName: onSubmitName,
      onChangeName: onChangeName,
      onChangedBackup: onChangedBackup,
      onSubmit: onSubmit,
      onChangedChangePin: onChangedChangePin,
      onSubmitChangePin: submitChangePin,
      submitChangePin: _changePin,
      submitBackUpKey: submitBackUpKey,
      changeName: _changeName,
      deleteAccout: deleteAccout,
      isBindAcc: isBindAcc,
      bindAcc: bindAcc
    );
  }
}
