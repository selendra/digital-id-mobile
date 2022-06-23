import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/provider/api_provider.dart';

class AppServices {
  
  Color hexaCodeToColor(String hexaCode) {
    /* Convert Hexa Color */
    String colornew = '0xFF$hexaCode';
    colornew = colornew.replaceAll('#', '');
    final colorint = int.parse(colornew);
    return Color(colorint);
    // return Color(AppUtils.convertHexaColor(hexaCode));
  }

  static ImagePicker imagePicker = ImagePicker();

  static Future<XFile> pickImage(ImageSource source) async {

    final pickedFile = await imagePicker.pickImage(source: source, imageQuality: 90);
    
    return pickedFile!;
  }

  Future<void> qrShare(GlobalKey globalKey, String _wallet) async {
    try {
      final RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 5.0);
      final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await File("${tempDir.path}/selendra.png").create();
      await file.writeAsBytes(pngBytes);

      FlutterShare.share(title: file.path, text: _wallet);
    } catch (e) {
      // if (ApiProvider().isDebug == false) print("Error qrShare ${e.toString()}");
    }
  }

  Future<void> loginEncryption(BuildContext context) async {



    // Encode Data
    // Map<String, dynamic>? map = {
    //   'name': _registration.usrName ?? '',
    //   'email': _registration.email,
    //   'password': _registration.password,
    //   'seed': _seed
    // };
    
    // // Encrypt Data
    // Encrypted _encrypted = Encryption().encryptAES(json.encode(map));
    // await StorageServices.storeData(_encrypted.bytes, DbKey.sensitive);

    // await getCurrentAccount().then((value) async {
    // print("Finish getCurrentAccount");
    //   // Make Web3 account Link with Email Address
    //   await createWeb3linkSel(email: _registration.email);
    //   print("finish createWeb3linkSel");
    // });
  }

//   static int myNumCount = 0;

//   static Future noInternetConnection(GlobalKey<ScaffoldState> globalKey) async {
//     try {
//       final Connectivity _connectivity = Connectivity();

//       final myResult = await _connectivity.checkConnectivity();

//       _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//         if (result == ConnectivityResult.none) {
//           openSnackBar(globalKey, AppString.contentConnection);
//         } else {
//           // ignore: deprecated_member_use
//           globalKey.currentState!.removeCurrentSnackBar();
//         }
//       });

//       if (myResult == ConnectivityResult.none) {
//         openSnackBar(globalKey, AppString.contentConnection);
//       }
//     } catch (e) {}
//   }

//   static Future connectivityStatus(BuildContext context) async {
//     try {
//       final Connectivity _connectivity = Connectivity();

//       final myResult = await _connectivity.checkConnectivity();

//       _connectivity.onConnectivityChanged
//           .listen((ConnectivityResult result) async {
//         if (result == ConnectivityResult.none) {
//           await dialogSuccess(context, Text(''), Text(''));
//         }
//       });

//       if (myResult == ConnectivityResult.none) {
//         await dialogSuccess(context, Text(''), Text(''));
//       }
//     } catch (e) {}
//   }

//   static void openSnackBar(GlobalKey<ScaffoldState> globalKey, String content) {
//     // ignore: deprecated_member_use
//     globalKey.currentState!.showSnackBar(snackBarBody(content, globalKey));
//   }

//   // ignore: avoid_void_async
//   static void closeSnackBar(
//       GlobalKey<ScaffoldState> globalKey, String content) async {
//     // await globalKey.currentState.showSnackBar(snackBarBody(content, globalKey)).closed.then((value) =>
//     //   print("value $value")
//     // );
//   }

//   static SnackBar snackBarBody(String content, globalKey) {
//     return SnackBar(
//       behavior: SnackBarBehavior.floating,
//       duration: const Duration(days: 365),
//       backgroundColor: Colors.red,
//       content: Text(content,
//           style: const TextStyle(
//             color: Colors.white,
//           )),
//       action: SnackBarAction(
//         label: "Close",
//         textColor: Colors.white,
//         onPressed: () {
//           globalKey.currentState.removeCurrentSnackBar();
//         },
//       ),
//     );
//   }

//   // ignore: avoid_void_async
//   Future<void> clearStorage() async {
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     await sharedPreferences.clear();
//   }

//   // Remove Zero At The Position Of Phone Number
//   static String removeZero(String number) {
//     return number.replaceFirst("0", "", 0);
//   }

//   static double getRadienFromDegree(double degree) {
//     const double unitRadien = 57.295779513;
//     return degree / unitRadien;
//   }

//   static Timer appLifeCycle(Timer timer) {
//     return timer;
//   }

//   static Map<String, dynamic> emptyMapData() {
//     return Map<String, dynamic>.unmodifiable({});
//   }

//   // ignore: avoid_void_async
//   static void timerOutHandler(http.Response res, Function timeCounter) async {
//     Timer.periodic(const Duration(seconds: 1), (Timer timer) {
//       if (timer.tick <= 10) {
//         timeCounter(timer);
//         // ignore: invariant_booleans
//       } else if (timer.tick > 10) timer.cancel();
//     });
//   }

//   Future<bool> checkBiometrics(BuildContext context) async {
//     bool canCheckBiometrics = false;
//     try {
//       // Check For Support Device
//       bool support = await LocalAuthentication().isDeviceSupported();
//       if (support) {
//         canCheckBiometrics = await LocalAuthentication().canCheckBiometrics;
//       } else {
//         await showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0)),
//               title: Align(
//                 child: MyText(
//                   text: "Oops",
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               content: Padding(
//                 padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
//                 child: Text("Your doesn't support finger print",
//                     textAlign: TextAlign.center),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Close'),
//                 ),
//               ],
//             );
//           },
//         );
//       }

//       // ignore: unused_catch_clause
//     } on PlatformException catch (e) {
//       // print("Erorr $e");
//       // canCheckBiometrics = false;
//     }

//     return canCheckBiometrics;
//   }

//   static Future<String>? getPrivateKey(String pin, BuildContext context) async {
//     String privateKey = '';
//     try {
//       final encrytKey = await StorageServices().readSecure(DbKey.private);
//       privateKey = await Provider.of<ApiProvider>(context, listen: false).decryptPrivateKey(encrytKey!, pin);
//     } catch (e) {
//       await customDialog(context, 'Opps', 'PIN verification failed');
//     }
//     return privateKey;
//   }

//   static List<List<double>> flListToList(List<FlSpot> flList) {
//     List<List<double>> tmp = [];
//     flList.forEach((element) {
//       tmp.add(
//         List.from([
//           element.x,
//           element.y
//         ])
//       );
//     });

//     return tmp;
//   }
  
//   static List<FlSpot> jsonToFlList(dynamic flJson) {
//     List<FlSpot> tmp = [];
//     flJson.forEach((element) {
//       tmp.add(
//         FlSpot(element[0], element[1])
//       );
//     });
//     return tmp;
//   }
// }

// class Encryptt {
//   static String passwordToEncryptKey(String password) {
//     String passHex = hex.encode(utf8.encode(password));
//     if (passHex.length > 32) {
//       return passHex.substring(0, 32);
//     }
//     return passHex.padRight(32, '0');
//   }
// }

// class AppUpdate {
  
//   Future<AppUpdateInfo> checkUpdate() async {
//     return await InAppUpdate.checkForUpdate();
//   }

//   Future<void> performImmediateUpdate() async {
//     await InAppUpdate.performImmediateUpdate();
//   }
}