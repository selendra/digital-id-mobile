import 'package:digital_id/all_export.dart';

class MyFlatButton extends StatelessWidget {
  final String? textButton;
  final String? buttonColor;
  final String? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final EdgeInsetsGeometry? edgeMargin;
  final EdgeInsetsGeometry? edgePadding;
  final bool? hasShadow;
  final Function? action;
  final double? width;
  final double? height;
  final bool? isTransparent;

  const MyFlatButton({
    this.textButton,
    this.buttonColor = AppColors.secondary,
    this.textColor = AppColors.whiteColor,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 18,
    this.edgeMargin = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.edgePadding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.hasShadow = false,
    this.width = double.infinity,
    this.height,
    this.isTransparent = false,
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: edgePadding,
      margin: edgeMargin,
      width: width,
      height: height,

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), 
        boxShadow: [
          if (hasShadow!)
            BoxShadow(
              color: Colors.black54.withOpacity(0.3),
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: const Offset(2.0, 5.0),
            )
        ]
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: action == null ? null : (){
          action!();
        },
        color: isTransparent! ? Colors.transparent : HexColor(buttonColor!),
        disabledColor: Colors.grey.shade700,
        focusColor: HexColor(AppColors.secondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: MyText(
          text: textButton!,
          color: textColor!,
          fontWeight: fontWeight!,
        ),
      ),
    );
  }
}

class MyGradientButton extends StatelessWidget {

  final String? textButton;
  final Widget? child;
  final String? buttonColor;
  final String? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final EdgeInsetsGeometry? edgeMargin;
  final EdgeInsetsGeometry? edgePadding;
  final bool? hasShadow;
  final Function? action;
  final double? width;
  final double? height;
  final bool? isTransparent;
  final List<String>? lsColor;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const MyGradientButton({
    this.child,
    this.textButton,
    this.lsColor = const [ "#F27649", "#F28907" ],
    this.buttonColor = AppColors.secondary,
    this.textColor = AppColors.whiteColor,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 18,
    this.edgeMargin = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.edgePadding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.hasShadow = false,
    this.width = double.infinity,
    this.height,
    this.isTransparent = false,
    required this.begin,
    required this.end,
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgePadding,
      margin: edgeMargin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [HexColor(lsColor![0]), HexColor(lsColor![1])],
          begin: begin,
          end: end, 
          stops: [0.25, 0.75],
        ),
        // color: action == null ? Colors.white.withOpacity(0.06) : null
      ),
      child: MaterialButton(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: child ?? MyText(
          text: textButton!,
          color: textColor!,
          fontWeight: fontWeight!,
        ),
        onPressed: action == null ? null : (){
          action!();
        },
      ),
    );
  }
}