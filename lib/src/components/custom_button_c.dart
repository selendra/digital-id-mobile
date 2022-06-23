import 'package:wallet_apps/index.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final Color? colorBtn;
  final Color? colorText;
  final EdgeInsetsGeometry? edgePadding;
  CustomButton({
    this.text, this.colorBtn, this.colorText, this.onPressed, this.edgePadding, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 20;

    return Padding(
      padding: edgePadding ?? EdgeInsets.zero,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: btnHeight,
        child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: colorBtn),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                alignment: Alignment.center,
                padding: MaterialStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: BorderSide(color: hexaCodeToColor(AppColors.primaryColor))
                  ),
                )
              ),
              onPressed: onPressed,
              child: MyText(
                textAlign: TextAlign.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                text: text!,
                fontWeight: FontWeight.bold,
                color2: Colors.white,
              ),
            )),
      )
    );
  }
}

class CustomButtonIcon extends StatelessWidget {
  final bool? bold;
  final String? text;
  final Function()? onPressed;
  final Color? colorBtn;
  final Color? colorText;
  final Icon? icon;
  const CustomButtonIcon({
    this.bold = false,
    this.text, 
    this.colorBtn, 
    this.colorText, 
    this.onPressed, 
    this.icon,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 20;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: btnHeight,
      child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: colorBtn),
          child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                alignment: Alignment.center,
                // padding: MaterialStateProperty.all(
                //     const EdgeInsets.only(top: 5, bottom: 5)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.transparent),
              ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Container()),
                MyText(
                  text: text!,
                  fontWeight: FontWeight.bold,
                  color2: colorText,
                ),
                Expanded(child: Container()),
                icon!,
              ],
            ),
          )),
    );
  }
}
