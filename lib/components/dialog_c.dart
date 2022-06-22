import 'dart:ui';

import 'package:digital_id/all_export.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class DialogComponents {
  Future<void> dialogCustom({ required BuildContext? context, String? titles, String? contents, Widget? contents2, LottieBuilder? lottie, Image? image, String? textButton, btn, btn2, bool? isDarkTheme}) async {
    return await showDialog(
      context: context!, 
      builder: (BuildContext context){
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            backgroundColor: HexColor(AppColors.bluebgColor),
            title: titles != null ? MyText(
              text: titles,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor//isDarkTheme == false ? AppColors.darkCard : AppColors.whiteHexaColor,
            ) : Container(),
            buttonPadding: btn2 != null ? const EdgeInsets.only(left: 24, right: 24, bottom: 24) : EdgeInsets.zero,
            content: contents != null ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
        
                lottie != null ? lottie : Container(),
                
                lottie != null ? SizedBox(height: 3) : Container(),
                
                image != null ? image : Container(),
                
                image != null ? SizedBox(height: 3) : Container(),
                MyText(
                  text: contents,
                  fontSize: 17,
                  color: AppColors.whiteColor, 
                )
              ],
            ) : contents2,
            actions: [
              btn ?? Container(),
        
              btn2 ?? TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero)
                ),
                onPressed: () async {
                  // await FlutterScreenshotSwitcher.enableScreenshots();
                  Navigator.pop(context);
                },
                child: MyText(
                  text: "Close",
                  color: AppColors.whiteColor
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

void messageToast(){

        
  // MotionToast.success(
  //   title:  Text("Success"),
  //   description:  Text("Scan had connected"),
  //   layoutOrientation: ORIENTATION.ltr,
  //   animationType: ANIMATION.fromLeft, width:  300,
  //   position: MOTION_TOAST_POSITION.top,
  // ).show(context);
}