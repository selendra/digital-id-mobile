import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_id/components/walletConnect_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/main.dart';
import 'package:digital_id/screens/wallet_connect/wallet_connect.dart';

class ScanConnectBody extends StatelessWidget {

  final String? wcUrl;
  final TextEditingController emailInputController;
  final TextEditingController passwordInputController;
  final bool? isChecked;
  final Function? handleRememberMe;
  final GlobalKey<FormState> formKey;
  final Function? validator;
  final Function? submitLogin;
  final WalletConnectComponent? wConnectC;

  const ScanConnectBody({
    Key? key, 
    this.wcUrl,
    required this.emailInputController, 
    required this.passwordInputController, 
    this.handleRememberMe, 
    this.isChecked = false,
    required this.formKey,
    this.validator,
    this.submitLogin,
    this.wConnectC
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text("Connect with DApp"),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: paddingSize, right: paddingSize, top: paddingSize),
          child: Stack(
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(bottom: paddingSize),
                    child: SvgPicture.asset(AppConfig.logoPath+"selendra.svg"),
                  ),

                  MyText(
                    text: "SELENDRA wants to connect to your wallet",
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    bottom: paddingSize
                  ),

                  MyText(
                    text: "https://app.uniswap.org",
                    bottom: paddingSize,
                    color2: Colors.grey,
                  ),

                  Card(
                    margin: EdgeInsets.only(bottom: paddingSize),
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [

                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                color: HexColor("#00BCFF").withOpacity(0.1),
                                padding: EdgeInsets.all(10),
                                width: 60, height: 60,
                                child: SvgPicture.asset(AppConfig.logoPath+"selendra.svg"),
                              ),
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Selendra",
                                    bottom: 5
                                  ),
                                  MyText(
                                    text: "0x68",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color2: Colors.grey,
                                  )
                                ],
                              ),
                            ),

                            Expanded(child: Container(),),
                            Icon(Icons.arrow_forward_ios)
                          ]
                        )
                      ),
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: paddingSize),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppConfig.iconPath+"wallet.svg", width: 15,),
                              MyText(
                                left: 10,
                                text: "View your wallet balance and activity"
                              )
                            ]
                          )
                        ),

                        Row(
                          children: [
                            SvgPicture.asset(AppConfig.iconPath+"secure_check.svg", width: 15),
                            MyText(
                              left: 10,
                              text: "Request approval for transactions"
                            )
                          ]
                        )
                      ],
                    ),
                  ),

                ],
              ),

              Positioned(
                bottom: paddingSize, 
                left: 0, right: 0,
                child: SubmitButton(
                  text: 'CONNECT',
                  onPressed: () async {
                    // Connect And Ask To Approve
                    wConnectC!.qrScanHandler(wcUrl!);
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}