import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';

class MyDialog{

  dialogLoading(BuildContext context, {String? content}) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return progress(content: content);
        // WillPopScope(
        //   onWillPop: () => Future(() => false),
        //   child: ,
        // );
      }
    );
  }

  Future<void> customDialog(BuildContext context, String title, String contents, {Widget? btn2}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Align(
            child: Text(title, style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text(contents, textAlign: TextAlign.center),
          ),
          actions: <Widget>[
            btn2 ?? Container(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: MyText(text: 'Close', fontWeight: FontWeight.bold,),
            ),
          ],
        );
      },
    );
  }

  /* Progress */
  Widget progress({String? content}) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation(HexColor("#F39D0C"))),
              if (content == null)
                Container()
              else
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 16.0),
                  child: MyText(text: content, color: "#FFFFFF"),
                ),
            ],
          )
        ],
      ),
    );
  }
}