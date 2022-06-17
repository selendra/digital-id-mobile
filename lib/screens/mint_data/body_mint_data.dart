import 'package:digital_id/all_export.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/main.dart';

class MintDataBody extends StatelessWidget{
  
  final String? seed;

  MintDataBody({this.seed});

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppConfig.illusPath+"warning.svg", width: MediaQuery.of(context).size.width/2),
            MyText(
              top: paddingSize,
              bottom: paddingSize,
              left: paddingSize,
              right: paddingSize,
              text: "The mnemonic is used to recover the wallet or repeat the wallet password, copy it to the paper accurately, and store it in a safe place that only you know."
            ),

            MyText(
              top: paddingSize,
              bottom: paddingSize,
              left: paddingSize,
              right: paddingSize,
              text: "The mnemonic is used to recover the wallet or repeat the wallet password, copy it to the paper accurately, and store it in a safe place that only you know."
            ),

            Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: getColumn(seed ?? "", 0),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: getColumn(seed ?? "", 1),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: getColumn(seed ?? "", 2),
                  ),
                ],
              ),
            
            ElevatedButton(
              onPressed: (){}, 
              child: MyText(
                text: "Export Seed"
              )
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getColumn(String seed, int pos) {
    var list = <Widget>[];
    var se = seed.split(' ');
    var colSize = se.length ~/ 3;

    for (var i = 0; i < colSize; i++) {
      list.add(Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: grey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        // color: grey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: i * 3 + pos + 1 < 10
              ? Text(
                  '  ' + (i * 3 + pos + 1).toString() + '.  ' + se[i * 3 + pos],
                  style: TextStyle(color: blackColor, fontSize: 14),
                )
              : Text(
                  (i * 3 + pos + 1).toString() + '.  ' + se[i * 3 + pos],
                  style: TextStyle(color: blackColor, fontSize: 14),
                ),
        ),
      ));
    }
    return list;
  }
}