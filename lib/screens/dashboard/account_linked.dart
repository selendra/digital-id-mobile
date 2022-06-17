import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_id/components/walletConnect_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/main.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/provider/home_p.dart';

class AccountLinked extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletConnectComponent>(
      builder: (context, provider, widget){
        return Scaffold(
          backgroundColor: whiteColor,
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: paddingSize, right: paddingSize, top: paddingSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(bottom: paddingSize),
                  child: Image.asset(AppConfig.logoPath+"mptc.png", width: 80,),
                ),

                MyText(
                  text: "Ministry of Post and Telecommunication",
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  bottom: paddingSize+paddingSize
                ),

                Consumer<HomeProvider>(
                  builder: (context, provider, widget){
                    return Row(
                      children: [
                        MyText(
                          text: "MPTC"
                        ),
                        Expanded(
                          child: MyText(
                            textAlign: TextAlign.end,
                            text: provider.isConnectedMPTC ? "connecting" : "not connect",
                            color2: provider.isConnectedMPTC ? Colors.green : Colors.grey,
                            overflow: TextOverflow.ellipsis,
                          )
                        ),
                      ]
                    );
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: paddingSize, bottom: paddingSize),
                  child: Divider(
                    height: 1,
                  )
                ),

                Consumer<ApiProvider>(
                  builder: (context, provider, widget){
                    return Row(
                      children: [
                        MyText(
                          text: "Address"
                        ),
                        Expanded(
                          child: MyText(
                            textAlign: TextAlign.end,
                            text: provider.accountM.address == null ? '...' :  provider.accountM.address!.replaceRange( 10, provider.accountM.address!.length - 10, "....."),
                            color2: Colors.grey,
                          )
                        ),
                      ]
                    );
                  }
                ),

                Padding(
                  padding: EdgeInsets.only(top: paddingSize, bottom: paddingSize),
                  child: Divider(
                    height: 1,
                  )
                ),

                Consumer<ApiProvider>(
                  builder: (context, provider, widget){
                    return Row(
                      children: [ 
                        MyText(
                          text: "Network"
                        ),
                        Expanded(
                          child: MyText(
                            textAlign: TextAlign.end,
                            text: "fxqwjnewkjsdfksdlf",
                            color2: Colors.grey,
                          )
                        ),
                      ]
                    );
                  }
                ),

                Padding(
                  padding: EdgeInsets.only(top: paddingSize, bottom: paddingSize),
                  child: Divider(
                    height: 1,
                  )
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}