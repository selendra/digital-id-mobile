

import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/custom_button.c.dart';
import 'package:digital_id/core/config/app_config.dart';

class WelcomeBody extends StatelessWidget {

  // WelcomeBody({this.inputController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
    
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/logos/sel.png",
                  // height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
                SizedBox(
                  height: 40,
                ),
          
                MyText(
                  text: "Welcome!",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.whiteColor
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MyText(
                    text: "Bitriel offer users to store, make transaction, invest, buy, sell crypto assets, and more!",
                    color: AppColors.whiteColor
                  ),
                )
              ]
            )
          ),
          
          Column(
            children: [
              MyGradientButton(
                edgeMargin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                textButton: "Get Started",
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                action: () {
                  // PassCodeComponent().passCode(context: context, inputController: inputController!);
    
                  // Navigator.push(context, Transition(child: Passcode(label: PassCodeLabel.fromCreateSeeds,), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
                  // Navigator.pushNamed(context, AppString.contentBackup);
                  // Navigator.push(context,MaterialPageRoute(builder: (context) => ContentsBackup()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MyUserInfo("error shallow spin vault lumber destroy tattoo steel rose toilet school speed")));
                },
              ),
              MyFlatButton(
                isTransparent: true,
                buttonColor: AppColors.whiteColor,
                edgeMargin:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                textButton: "Restore Wallet",
                action: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Passcode(label: PassCodeLabel.fromImportSeeds)));
                  // Navigator.push(context, Transition(child: Passcode(label: PassCodeLabel.fromImportSeeds,), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
