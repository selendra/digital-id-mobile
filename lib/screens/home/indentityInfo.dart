import 'dart:io';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/main.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/provider/digital_id_p.dart';
import 'package:digital_id/theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_share/flutter_share.dart';
// import 'package:share/share.dart';
class IdentityInfo extends StatelessWidget{

  final DashBoardModel? dashBoardModel;
  final Function? submitEdit;

  IdentityInfo({this.dashBoardModel, this.submitEdit});
  
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: (){
                    FlutterShare.share(title: Provider.of<HomeProvider>(context, listen: false).homeModel.wallet);
                  }, 
                  icon: Icon(Icons.share)
                ),
                IconButton(
                  onPressed: (){

                    Clipboard.setData(
                      ClipboardData(text: Provider.of<HomeProvider>(context, listen: false).homeModel.wallet),
                    );
                    /* Copy Text */
                    ScaffoldMessenger(child: MyText(text: "Copied"));
                  }, 
                  icon: Icon(Icons.copy)
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: paddingSize*2),
              child: Consumer<HomeProvider>(
                builder: (context, provider, widget){
                  return Column(
                    children: [
                      QrImage(
                        data: provider.homeModel.wallet,
                        version: QrVersions.auto,
                        size: 250,
                        gapless: false,
                        // embeddedImage: const AssetImage('assets/logos/selendra.png'),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: const Size(80, 80),
                        ),
                      ),

                      MyText(
                        width: MediaQuery.of(context).size.width/1.5,
                        text: provider.homeModel.wallet 
                      )
                    ],
                  );
                },
              )
            ),
            

            // Consumer<IdentifierProvider>(
            //   builder: (context, provider, widget){
            //     return provider.alreadySetup == true 
            //     ? MyText(
            //       text: provider.identifierModel!.title, 
            //       textAlign: TextAlign.left, 
            //       fontWeight: FontWeight.w600,
            //       top: paddingSize,
            //       left: paddingSize,
            //     ) 
            //     : Container();
            //   }
            // ),

            Consumer<HomeProvider>(
              builder: (context, provider, widget){

                print(provider.successSubmitToBlockchain);
                if (provider.successSubmitToBlockchain == false) 
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(
                        Colors.transparent
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        provider.readyToSubmit ? HexColor(AppColors.primary).withOpacity(0.2) : Colors.grey[350]
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)
                        )
                      ),
                    ),
                    onPressed: provider.readyToSubmit ? (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateWalletPage()));
                    } : null, 
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: btnHeight,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      alignment: Alignment.center,
                      child: MyText(
                        text: "Submit to Blockchain",
                        fontWeight: FontWeight.w600,
                        color: provider.readyToSubmit ? AppColors.primary : "#000000",
                      )
                    )
                  )

                  // : Card(
                  //   child: Column(
                  //     children: [
                  //       Image.file(File(provider.identifierModel!.frontImage!), width: 400, height: 200,)
                  //     ],
                  //   ),
                  // )
                );

                if (provider.successSubmitToBlockchain == true)
                return Column(
                  children: [
                    SvgPicture.asset(AppConfig.iconPath+"link.svg", width: 50,),
                    MyText(text: "Your account is minted with blockchain", color: AppColors.primary)
                  ],
                );

                return Container();
              },
            ),

            Consumer<DigitalIDProvider>(
              builder: (context, provider, widget){
                return provider.identifierModel!.completedSetpUpID == false ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "Please get your "
                    ),
                    TextButton(
                      onPressed: (){
                        
                      }, 
                      child: MyText(
                        text: "Digital ID",
                        color: AppColors.primary,
                      ),
                    ),
                    MyText(
                      text: "before continue"
                    ),
                  ],
                ) : Container();
              }
            )

          ],
        )
      ),
    );
  }
}