import 'package:digital_id/all_export.dart';
class MyText extends StatelessWidget{

  final String? text; 
  final String? color; 
  final Color? color2;
  final double? fontSize; 
  final FontWeight? fontWeight;
  final double? top; 
  final double? right; 
  final double? bottom; 
  final double? left;
  final double? pTop; 
  final double? pRight; 
  final double? pBottom; 
  final double? pLeft;
  final double? width; 
  final double? height; 
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final AlignmentGeometry? alignment;

  MyText({
    required this.text, 
    this.color = "#000000",
    this.color2,
    this.fontSize = 18, this.fontWeight = FontWeight.normal,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0,
    this.pLeft = 0, this.pRight = 0, this.pTop = 0, this.pBottom = 0,
    this.width, this.height, this.textAlign = TextAlign.center,
    this.overflow,
    this.alignment,
  });
  
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.fromLTRB(left!, top!, right!, bottom!),
      padding: EdgeInsets.fromLTRB(pLeft!, pTop!, pRight!, pBottom!),
      alignment: alignment,
      child: SizedBox(
        width: width,
        height: height,
        child: Text(
          text!,
          style: 
          // GoogleFonts.inter(
          //   fontWeight: fontWeight,
          //   color: color2 ?? HexColor(color!),
          //   fontSize: fontSize,),
          TextStyle(
            fontWeight: fontWeight,
            color: color2 ?? HexColor(color!),
            fontSize: fontSize,
          ),
          textAlign: textAlign,
          overflow: overflow,
        )
      ),
    );
  }
}