import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/alert_dialog_c.dart';
import 'package:digital_id/components/qr_scanner.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:digital_id/components/walletConnect_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/main.dart';
import 'package:digital_id/models/dashboard_m.dart';
import 'package:digital_id/models/digital_id_m.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/provider/digital_id_p.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/screens/wallet_connect/wallet_connect.dart';
import 'package:digital_id/services/storage.dart';
import 'package:wallet_connect/wallet_connect.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountBody extends StatelessWidget {
  
  const AccountBody({ Key? key }) : super(key: key);

  final double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, provider, widget){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.arrow_back, color: Colors.black)
              ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: (){

                  }, 
                  icon: Icon(Icons.nightlight_outlined, color: Colors.black)
                ),
              )
            ],
          ),
          backgroundColor: whiteColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: paddingSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Consumer<HomeProvider>(
                    builder: (context, provider, widget){
                      print("provider.homeModel.profile ${provider.homeModel.profile}");
                      return Padding(
                        padding: EdgeInsets.only(left: paddingSize - 5, top: paddingSize, bottom: paddingSize),
                        child: Row(
                          children: [

                            Container(
                              height: 65, width: 65,
                              margin: EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(provider.homeModel.profile, fit: BoxFit.cover,),
                              )
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  fontSize: 17,
                                  textAlign: TextAlign.start,
                                  text: provider.homeModel.name == '' ? "N/A" : provider.homeModel.name,
                                  fontWeight: FontWeight.bold,
                                ),
                                MyText(
                                  text: provider.homeModel.email,
                                  color: "#535763",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )
                              ],
                            ),

                            Expanded(child: Container()),
                            
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                color: provider.successSubmitToBlockchain ? HexColor("#3DDAB4").withOpacity(0.28) : Colors.red.withOpacity(0.28),
                              ),
                              child: Row(
                                children: [
                                  if (provider.successSubmitToBlockchain)
                                  SvgPicture.asset(AppConfig.iconPath+"check.svg", width: 20, color: HexColor("#3DDAB4"),),

                                  MyText(
                                    left: 10,
                                    text: provider.successSubmitToBlockchain ? "Verified" : "Not verify",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color2: provider.successSubmitToBlockchain ? HexColor("#3DDAB4") : Colors.red,
                                  ),
                                ],
                              )
                            )
                          ],
                        )
                      );
                    },
                  ),

                  ListTile(
                    onTap: () async {
                      await MyDialog().customDialog(
                        context, 'Message', 'Profile feature is under construction'
                      );
                    },
                    title: Row(
                      children: [
                        SvgPicture.asset(AppConfig.iconPath+"profile2.svg", width: iconSize, height: iconSize,),
                        const SizedBox(width: 8,),
                        MyText(text: "Profile", textAlign: TextAlign.left, left: 10,fontSize: 20, fontWeight: FontWeight.w600,)
                      ],
                    )
                  ),
                  ListTile(
                    onTap: () async {
                      await MyDialog().customDialog(
                        context, 'Message', 'Profile feature is under construction'
                      );
                    },
                    title: Row(
                      children: [
                        SvgPicture.asset(AppConfig.iconPath+"wallet2.svg", width: iconSize, height: iconSize),
                        const SizedBox(width: 8,),
                        MyText(text: "Wallet", textAlign: TextAlign.left, left: 10,fontSize: 20, fontWeight: FontWeight.w600,)
                      ],
                    )
                  ),
                  ListTile(
                    onTap: () async {
                      await MyDialog().customDialog(
                        context, 'Message', 'Profile feature is under construction'
                      );
                    },
                    title: Row(
                      children: [
                        SvgPicture.asset(AppConfig.iconPath+"auction.svg", width: iconSize, height: iconSize),
                        const SizedBox(width: 8,),
                        MyText(text: "Auction", textAlign: TextAlign.left, left: 10,fontSize: 20, fontWeight: FontWeight.w600,)
                      ],
                    )
                  ),
                  ListTile(
                    onTap: () async {
                      await MyDialog().customDialog(
                        context, 'Message', 'Profile feature is under construction'
                      );
                    },
                    title: Row(
                      children: [
                        SvgPicture.asset(AppConfig.iconPath+"bridge.svg", width: iconSize, height: iconSize),
                        const SizedBox(width: 8,),
                        MyText(text: "Bridge", textAlign: TextAlign.left, left: 10,fontSize: 20, fontWeight: FontWeight.w600,)
                      ],
                    )
                  ),
                  ListTile(
                    onTap: () async {
                      await MyDialog().customDialog(
                        context, 'Message', 'Profile feature is under construction'
                      );
                    },
                    title: Row(
                      children: [
                        SvgPicture.asset(AppConfig.iconPath+"exchange.svg", width: iconSize, height: iconSize),
                        const SizedBox(width: 8,),
                        MyText(text: "Exchange", textAlign: TextAlign.left, left: 10,fontSize: 20, fontWeight: FontWeight.w600,)
                      ],
                    )
                  ),
                  ListTile(
                    onTap: () async {
                      await MyDialog().customDialog(
                        context, 'Message', 'Profile feature is under construction'
                      );
                    },
                    title: Row(
                      children: [
                        SvgPicture.asset(AppConfig.iconPath+"borrow.svg", width: iconSize, height: iconSize),
                        const SizedBox(width: 8,),
                        MyText(text: "Borrow", textAlign: TextAlign.left, left: 10,fontSize: 20, fontWeight: FontWeight.w600,)
                      ],
                    )
                  ),
                  ListTile(
                    onTap: () async {
                      await MyDialog().customDialog(
                        context, 'Message', 'Profile feature is under construction'
                      );
                    },
                    title: Row(
                      children: [
                        SvgPicture.asset(AppConfig.iconPath+"earn.svg", width: iconSize, height: iconSize),
                        const SizedBox(width: 8,),
                        MyText(text: "Earn", textAlign: TextAlign.left, left: 10,fontSize: 20, fontWeight: FontWeight.w600,)
                      ],
                    )
                  ),
                  ListTile(
                    onTap: () async {
                      await MyDialog().customDialog(
                        context, 'Message', 'Profile feature is under construction'
                      );
                    },
                    title: Row(
                      children: [
                        SvgPicture.asset(AppConfig.iconPath+"import seed.svg", width: iconSize, height: iconSize),
                        const SizedBox(width: 8,),
                        MyText(text: "Import seed", textAlign: TextAlign.left, left: 10,fontSize: 20, fontWeight: FontWeight.w600,)
                      ],
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: paddingSize, top: paddingSize),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(
                          Colors.transparent
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          HexColor("#E3E3E3")
                        ),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)
                          )
                        ),
                      ),
                      onPressed: () async{

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ToolsPage()));
                        await MyDialog().customDialog(
                          context, 
                          'Delete account', 
                          'Are you sure to delete your account?',
                          btn2: TextButton(
                            onPressed: () async {

                              WalletConnectComponent _session = Provider.of<WalletConnectComponent>(context, listen: false);
                              if ( _session.sessionStore != null){
                                _session.wcClient.killSession();
                              }
                              MyDialog().dialogLoading(context);

                              // Clear Cache Data
                              await StorageServices.clearAllData();

                              // Delete Account From Substrate
                              ApiProvider _api = Provider.of<ApiProvider>(context, listen: false);
                              await _api.apiKeyring.deleteAccount(
                                _api.getKeyring,
                                _api.getKeyring.current,
                              );

                              final home = Provider.of<HomeProvider>(context, listen: false);
                              home.homeModel = DashBoardModel();
                              home.readyToSubmit = false; 
                              home.setSuccessSubmitToBlockchain = false; 
                              home.setWallet = ''; 
                              final digital = Provider.of<DigitalIDProvider>(context, listen: false);
                              digital.identifierModel = DigitalIDModel();

                              await Future.delayed(Duration(seconds: 1), (){

                              }); 
                              Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
                            },
                            child: MyText(
                              text: 'Delete',
                              color2: Colors.red,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        );
                      }, 
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: btnHeight,
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(12),
                        // ),
                        alignment: Alignment.center,
                        child: MyText(
                          text: "Log Out",
                          fontWeight: FontWeight.bold,
                          color2: Colors.black,
                          fontSize: 20,
                        )
                      )
                    )
                  ),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}