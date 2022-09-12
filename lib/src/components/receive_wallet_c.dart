import 'dart:ui';
import 'package:share/share.dart';
import 'package:wallet_apps/index.dart';
import 'package:path_provider/path_provider.dart';

class GetWalletMethod {
  void platformChecker(BuildContext context) {
    // if (Platform.isAndroid)
    //   androidHighBright(context);
    // else
    //   iOSHighBright();
  }

  // Future<void> androidHighBright(BuildContext context) async {
  //   try {
  //     await AndroidPlatform.getBrightness();
  //     await AndroidPlatform.getBrightnessMode();
  //     if (AndroidPlatform.defaultBrightnessLvl < 50) {
  //       await AndroidPlatform.checkPermission().then((value) async {
  //         if (value == false) {
  //           await Component.messagePermission(
  //               context: context,
  //               content:
  //                   "Brightness is low that hard to scan! Click setting and turn on to allow auto-brightness mode",
  //               method: () async {
  //                 await AndroidPlatform.writePermission();

  //                 await AndroidPlatform.checkPermission().then((value) async {
  //                   if (value == true) {
  //                     Navigator.pop(context, true);
  //                   } else {
  //                     Navigator.pop(context, false);
  //                   }
  //                 });
  //               }).then((value) async {
  //             // Check User Enabled Permission
  //             if (value == true) {
  //               await AndroidPlatform.increaseBrightness();
  //             }
  //           });
  //         } else {
  //           await AndroidPlatform.increaseBrightness();
  //         }
  //       });
  //     }
  //   } on AndroidPlatform catch (e) {}
  // }

  // Future<void> iOSHighBright() async {
  //   try {
  //     await IOSPlatform.getBrightness().then((value) async {
  //       if (value < 40) {
  //         await IOSPlatform.setHighBrightness();
  //       }
  //     });
  //   } on PlatformException catch (e) {}
  // }

  Future<void> qrShare(GlobalKey globalKey, String _wallet) async {
    try {
      final RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 5.0);
      final ByteData? byteData =
          await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await File("${tempDir.path}/selendra.png").create();
      await file.writeAsBytes(pngBytes);

      Share.shareFiles([file.path], text: _wallet);
    } catch (e) {
      if (ApiProvider().isDebug == true) print("Error qrShare ${e.toString()}");
    }
  }

  void popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  /* Trigger Snack Bar Function */
  void snackBar(String contents, GlobalKey<ScaffoldState> _globalKey) {
    final snackbar = SnackBar(
      content: Text(contents),
    );
    // ignore: deprecated_member_use
    _globalKey.currentState!.showSnackBar(snackbar);
  }
}
