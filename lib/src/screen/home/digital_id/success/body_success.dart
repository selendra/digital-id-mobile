import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/digital_id/success/success.dart';

import '../build_dot_indecator.dart';

class SuccessSubmitBody extends StatelessWidget{

  final Function? method;

  SuccessSubmitBody({this.method});

  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 63),
          child: Stack(
            children: [

              Column(
                children: [

                  MyText(
                    top: paddingSize,
                    bottom: paddingSize,
                    text: "Well Done",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  
                  Image.asset("assets/logo/waiting.png"),

                  SizedBox(height: 5.h,),

                  MyText(
                    top: paddingSize,
                    bottom: paddingSize,
                    left: paddingSize*2,
                    right: paddingSize*2,
                    text: "Your profile is now being reviewed. You can expect it to finish in the next 24 hours.",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  

                ],
              ),

              Positioned(
                left: paddingSize,
                right: paddingSize,
                bottom: paddingSize,
                child: MyFlatButton(
                  textButton: "Finish",
                  buttonColor: AppColors.newPrimary,
                  action: () async {
                    Navigator.pushReplacement(context, Transition(child: HomePage(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
                  }
                ),
              )
            ]
          ),
        )
      )
    );
  }
}