import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/theme/theme.dart';

import '../screens/digital_id/build_dot_indecator.dart';

class SuccessSubmit extends StatelessWidget{

  final Function? method;
  final bool? isIndicator;

  SuccessSubmit({this.method, this.isIndicator = true});

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
                    text: "Success",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  isIndicator! ? const ReuseDotIndecator(indexPoint: 3) : Container(),
                  MyText(
                    top: paddingSize,
                    bottom: paddingSize,
                    left: paddingSize*2,
                    right: paddingSize*2,
                    text: "The entered recovery seeds is valid and matches the one in devices.",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),

                  Image.asset(AppConfig.illusPath+"illus_3d.png"),

                ],
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(paddingSize),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    child: Container(
                    height: btnHeight,
                    padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize),
                    width: MediaQuery.of(context).size.width,
                    child: MyText(
                        text: 'Finish',
                        color2: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (method != null) {
                        await method!();
                      } else {

                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPage()), (route) => false);
                      }
                    },
                  ),
                ),
              )
            ]
          ),
        )
      )
    );
  }
}