import 'package:digital_id/all_export.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyInputField extends StatelessWidget {
  @override
  // ignore: overridden_fields
  final Key? key;
  final String? prefixText;
  final String? textColor;
  final int? maxLine;
  final double? pLeft, pTop, pRight, pBottom;
  final bool? obcureText;
  final bool? enableInput;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final Function? onTap;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool? autoFocus;
  final Function? validateField;
  final Function? onChanged;
  final Function? onSubmit;
  final String? hintText;

  const MyInputField(
      {/* User Input Field */
      this.key,
      this.prefixText,
      this.pLeft = paddingSize,
      this.pTop = 5.0,
      this.pRight = paddingSize,
      this.pBottom = 0,
      this.obcureText = false,
      this.enableInput = true,
      this.textInputFormatter,
      this.inputType = TextInputType.text,
      this.inputAction,
      this.maxLine = 1,
      this.onTap,
      @required this.controller,
      this.suffixIcon,
      this.textColor = "#FFFFFF",
      this.autoFocus,
      this.suffix,
      this.validateField,
      this.onChanged,
      @required this.onSubmit,
      this.hintText,
    });

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.fromLTRB(pLeft!, pTop!, pRight!, pBottom!),
        child: TextFormField(
          key: key,
          enabled: enableInput,
          autofocus: autoFocus ?? false,
          keyboardType: inputType,
          obscureText: obcureText!,
          controller: controller,
          onTap: onTap != null ? (){
            onTap!();
          } : null,
          textInputAction:
            // ignore: prefer_if_null_operators
            inputAction == null ? TextInputAction.next : inputAction,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15
          ),
          validator: (String? value){
            return validateField!(value);
          },
          maxLines: maxLine,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              color: HexColor(AppColors.whiteColor),
            ),
            prefixText: prefixText,

            prefixStyle: TextStyle(color: HexColor(AppColors.textColor), fontSize: 18.0),
            /* Prefix Text */
            filled: true,
            fillColor: Colors.white.withOpacity(0.06),

            enabledBorder: myTextInputBorder(controller!.text != ""
              ? Colors.white.withOpacity(0.06)
              : Colors.white.withOpacity(0.06)
            ),
            /* Show Error And Red Border */
            focusedBorder: myTextInputBorder(Colors.white.withOpacity(0.06)),
            /* Default Focuse Border Color*/
            focusColor: Colors.white.withOpacity(0.06),
            /* Border Color When Focusing */
            contentPadding: const EdgeInsets.fromLTRB(
                paddingSize, 0, paddingSize, 0), // Default padding = -10.0 px
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffix: suffix,
          ),
          inputFormatters: textInputFormatter,
          /* Limit Length Of Text Input */
          onChanged: (String? value){
            if (onChanged != null) onChanged!(value);
          },
          onFieldSubmitted: (value) {
            onSubmit!();
          },
        ));
  }
}

/* User input Outline Border */
OutlineInputBorder myTextInputBorder(Color borderColor) {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
      ),
      borderRadius: BorderRadius.circular(8));
}



class MySeedField extends StatelessWidget {
  @override
  // ignore: overridden_fields
  final Key? key;
  final String? hintText;
  final String? prefixText;
  final String? textColor;
  final int? maxLine;
  final double? pLeft, pTop, pRight, pBottom;
  final bool? obcureText;
  final bool? enableInput;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final Function? onTap;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool? autoFocus;
  final Function? validateField;
  final Function? onChanged;
  final Function? onSubmit;

  const MySeedField(
      {/* User Input Field */
      this.key,
      this.hintText,
      this.prefixText,
      this.pLeft = 16.0,
      this.pTop = 5.0,
      this.pRight = 16.0,
      this.pBottom = 0,
      this.obcureText = false,
      this.enableInput = true,
      this.textInputFormatter,
      this.inputType = TextInputType.text,
      this.inputAction,
      this.maxLine = 1,
      this.onTap,
      @required this.controller,
      @required this.focusNode,
      this.suffixIcon,
      this.textColor = "#FFFFFF",
      this.autoFocus,
      this.suffix,
      this.validateField,
      this.onChanged,
      @required this.onSubmit});

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.fromLTRB(pLeft!, pTop!, pRight!, pBottom!),
        child: TextFormField(
          key: key,
          enabled: enableInput,
          focusNode: focusNode,
          autofocus: autoFocus ?? false,
          keyboardType: inputType,
          obscureText: obcureText!,
          controller: controller,
          onTap: onTap != null ? (){
            onTap!();
          } : null,
          textInputAction:
              // ignore: prefer_if_null_operators
              inputAction == null ? TextInputAction.next : inputAction,
          style: TextStyle(
            color: HexColor(AppColors.whiteColor),
            fontSize: 16.0
          ),
          validator: (String? value){
            return validateField!(value);
          },
          textAlignVertical: TextAlignVertical.top,
          maxLines: maxLine,
          decoration: InputDecoration(
            
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 15,
              color: HexColor(AppColors.shadowBlueColor),
              // fontSize: 16.0,
              fontWeight: FontWeight.w600
            ),
            prefixText: prefixText,

            prefixStyle: TextStyle(
                color: HexColor(AppColors.textColor), fontSize: 18.0),
            /* Prefix Text */
            filled: true,
            fillColor: HexColor(AppColors.whiteColor).withOpacity(0.06),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0.0,
              ),
            ),

            // enabledBorder: MySeedFieldBorder(controller!.text != ""
            //     ? isDarkTheme
            //         ? hexaCodeToColor(AppColors.whiteColorHexa).withOpacity(0.3)
            //         : hexaCodeToColor(AppColors.textColor).withOpacity(0.3)
            //     : hexaCodeToColor(AppColors.darkSecondaryText)),
            /* Enable Border But Not Show Error */
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0.0,
              ),
            ),
            /* Show Error And Red Border */
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0.0,
              ),
            ),
            // focusedBorder: MySeedFieldBorder(isDarkTheme
            //     ? hexaCodeToColor(AppColors.whiteColorHexa).withOpacity(0.3)
            //     : hexaCodeToColor(AppColors.secondary)),
            /* Default Focuse Border Color*/
            focusColor: HexColor(AppColors.whiteColor),
            /* Border Color When Focusing */
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 1),
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffix: suffix,
          ),
          inputFormatters: textInputFormatter,
          /* Limit Length Of Text Input */
          onChanged: (String? value){
            if (onChanged != null) onChanged!(value);
          },
          onFieldSubmitted: (value) {
            onSubmit!();
          },
        ));
  }
} 
