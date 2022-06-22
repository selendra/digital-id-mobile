// import 'dart:convert';
// import 'dart:math';
// import 'package:provider/provider.dart';
// import 'package:digital_id/all_export.dart';
// import 'package:digital_id/components/alert_dialog_c.dart';
// import 'package:digital_id/core/config/app_config.dart';
// import 'package:digital_id/provider/api_provider.dart';
// import 'package:digital_id/provider/digital_id_p.dart';
// import 'package:digital_id/provider/home_p.dart';
// import 'package:digital_id/provider/registration_p.dart';
// import 'package:digital_id/components/success.dart';
// import 'package:digital_id/services/storage.dart';
// import 'package:encrypt/encrypt.dart';


// class VerifyPassphrase extends StatefulWidget {

//   final String? seed;
  
//   VerifyPassphrase({this.seed});

//   @override
//   State<VerifyPassphrase> createState() => _VerifyPassphraseState();
// }

// class _VerifyPassphraseState extends State<VerifyPassphrase> {

//   final TextEditingController passphraseController = TextEditingController();

//   List<String>? _lsSeed = [];

//   // Random 3 Each Number
//   String? _rd1, _rd2, _rd3;

//   RegistrationProvider? _registerProvider;
//   ApiProvider? _apiProvider;

//   @override
//   void initState() {
    
//     _apiProvider = Provider.of<ApiProvider>(context, listen: false);
//     _registerProvider = Provider.of<RegistrationProvider>(context, listen: false);

//     _splitSeed();
//     _randomThreeEachNumber();
//     super.initState();
//   }

//   void _randomThreeEachNumber(){

//     _rd1 = Random().nextInt(12).toString();
//     while(_rd1 == "0"){
//       _rd1 = Random().nextInt(12).toString();
//     }
//     _rd2 = Random().nextInt(12).toString();
    
//     while(_rd2 == _rd1 || _rd2 == "0"){
//       _rd2 = Random().nextInt(12).toString();
//       if (_rd2 != _rd1) break;
//     }
//     _rd3 = Random().nextInt(12).toString();
//     while(_rd3 == _rd1 || _rd3 == _rd2 || _rd3 == "0"){
//       _rd3 = Random().nextInt(12).toString();
//       if (_rd2 != _rd1 && _rd3 != _rd2) break;
//     }

//     setState(() { });
//   }
  
//   Future<void> _verify() async {
//     print("verify");
//     List<String> _tmp = passphraseController.text.split(" ");
//     print("_tmp $_tmp");
//     if (
//       _tmp[0] == _lsSeed![int.parse(_rd1!) - 1]
//       // _tmp[1] == _lsSeed![int.parse(_rd2!) - 1] && 
//       // _tmp[2] == _lsSeed![int.parse(_rd3!) - 1]
//     ){
//     // Show Loading
//       MyDialog().dialogLoading(context);
//       // await _apiProvider!.addAcc(context: context, usrName: _registerProvider!.usrName, password: _registerProvider!.password, seed: widget.seed).then((value) async {

//         // Encode Data
//         // Map<String, dynamic>? map = {
//         //   'usrName': _registerProvider!.usrName,
//         //   'email': _registerProvider!.email,
//         //   'password': _registerProvider!.password,
//         //   'seed': widget.seed
//         // };

//         Provider.of<HomeProvider>(context, listen: false).setSuccessSubmitToBlockchain = true;
        
//         // Encrypt Data
//         Encrypted _encrypted = Encryption().encryptAES(json.encode(Provider.of<DigitalIDProvider>(context, listen: false).blochainData));
//         await StorageServices.storeData(_encrypted.bytes, DbKey.sensitive);
//         await StorageServices.storeData(true, DbKey.blochchainData);

//         Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessSubmit(isIndicator: false,)));
        
//         // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPage()), (route) => false);
//       // });

//     } else {
//       await MyDialog().customDialog(context, "Oops", "Incorrect seed!\nplease try again");
//     }
//   }

//   void _splitSeed(){
//     _lsSeed = widget.seed!.split(" ");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VerifyPassphraseBody(
//       verify: _verify,
//       phraseKey: passphraseController,
//       rd1: _rd1
//     );
//   }
// }
