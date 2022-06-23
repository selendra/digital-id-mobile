import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';

class ColumnInfo extends StatelessWidget{
  
  final String? title;
  final String? subTitle;

  ColumnInfo({this.title, this.subTitle});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(text: title!, color2: greyColor, bottom: 5, textAlign: TextAlign.left, fontSize: 16,),
          MyText(text: subTitle!, color2: blackColor, fontWeight: FontWeight.w700, textAlign: TextAlign.left,),
        ]
      ),
    );
  }
}