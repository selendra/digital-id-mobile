import 'dart:ui';

import 'package:lottie/lottie.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/provider/receive_wallet_p.dart';

class DialogComponents {
  
  Future<void> seedDialog({BuildContext? context, String? contents, btn, bool? isDarkTheme}) async {
    return await showDialog(
      context: context!, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          backgroundColor: hexaCodeToColor(AppColors.whiteColor),
          title: MyText(
            fontSize: 20,
            text: "Mnemonic",
            fontWeight: FontWeight.bold,
            color: AppColors.darkCard,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              MyText(
                textAlign: TextAlign.left,
                text: AppString.screenshotNote,
                color: AppColors.darkCard,
                bottom: paddingSize,
              ),

              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: isDarkTheme! 
                  ? Colors.white.withOpacity(0.06)
                  : hexaCodeToColor(AppColors.whiteHexaColor),
                child: MyText(
                  text: contents,
                  textAlign: TextAlign.left,
                  fontSize: 18,
                  color: AppColors.newPrimary,
                  fontWeight: FontWeight.bold,
                  pLeft: 16,
                  right: 16,
                  top: 16,
                  bottom: 16,
                ),
              ),

              SizedBox(height: paddingSize),
              Consumer<ReceiveWalletProvider>(
                builder: (context, provider, widget){
                  return GestureDetector(
                    onTap: (){

                      Clipboard.setData(
                        ClipboardData(text: contents),
                      );
                      /* Copy Text */
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Seeds is copied'),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.copy, color: hexaCodeToColor(AppColors.darkCard), size: 15.sp,),

                        SizedBox(width: 2.w,),
                        MyText(
                          text: "Copy address",
                          color: AppColors.darkCard,
                        )
                      ],
                    ),
                  );
                }
              )

            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // await FlutterScreenshotSwitcher.enableScreenshots();
                Navigator.pop(context);
              },
              child: MyText(
                text: 'Close', 
                color: AppColors.newPrimary,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        );
    });
  }

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
            backgroundColor: hexaCodeToColor(AppColors.newBgColor),
            title: titles != null ? MyText(
              text: titles,
              fontWeight: FontWeight.bold,
              color: AppColors.newText//isDarkTheme == false ? AppColors.darkCard : AppColors.whiteHexaColor,
            ) : Container(),
            buttonPadding: btn2 != null ? EdgeInsets.only(left: 20, right: 20) : EdgeInsets.zero,
            content: contents != null ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
        
                lottie != null ? lottie : Container(),
                
                lottie != null ? SizedBox(height: 3.h) : Container(),
                
                image != null ? image : Container(),
                
                image != null ? SizedBox(height: 3.h) : Container(),
                MyText(
                  text: contents,
                  // fontSize: 17,
                  color: AppColors.newText, 
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
                  color: AppColors.newPrimary
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Future<void> dialogQR({ required BuildContext? context, required GlobalKey? keyQrShare, required Map<String, dynamic>? data, bool? isDarkTheme}) async {
    return await showDialog(
      context: context!, 
      builder: (BuildContext context){
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            backgroundColor: hexaCodeToColor(AppColors.newBgColor),
            content: Consumer<ApiProvider>(
              builder: (context, provider, widget){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
              
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        child: Image.asset(AppConfig.assetsPath+"SelendraCircle-Blue.png", fit: BoxFit.cover,),
                      ),
                    ),
              
                    MyText(
                      top: paddingSize,
                      text: data!['type'],
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    
                    MyText(
                      top: paddingSize-5,
                      text: "Scan the QR code",
                    ),
              
                    Container(
                      margin: EdgeInsets.symmetric(vertical: paddingSize*2),
                      child: qrCodeGenerator(
                        provider.accountM.address!,
                        "",
                        keyQrShare!,
                      ),
                    ),
                    
                    MyFlatButton(
                      textButton: "Share",
                      textColor: AppColors.whiteColor,
                      buttonColor: AppColors.newPrimary,
                      action: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            ),
            // actions: [
        
            //   TextButton(
            //     style: ButtonStyle(
            //       padding: MaterialStateProperty.all(EdgeInsets.zero)
            //     ),
            //     onPressed: () async {
            //       // await FlutterScreenshotSwitcher.enableScreenshots();
            //       Navigator.pop(context);
            //     },
            //     child: MyText(
            //       text: "Close",
            //       color: AppColors.lowWhite
            //     ),
            //   )
            // ],
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