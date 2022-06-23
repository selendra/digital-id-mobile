import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:digital_id/services/services_s.dart';
import 'package:image_picker/image_picker.dart';

class Components {
  
  Future<void> imageOption({
    @required BuildContext? context, 
    @required Function? getImage, 
    /// For Which Image Section That Need to Pick Image
    String? label
  }) async {
    final selected = await showModalBottomSheet(
      context: context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      builder: (context){
        return Container(
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                height: 5,
                width: 134,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: HexColor("#CFD2D8"),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),

              Align(
                alignment: Alignment.topCenter,
                child: MyText(
                  top: 8,
                  text: "Add Item",
                  bottom: 20,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Divider(
              //   thickness: 0.2,
              //   color: Colors.black54.withOpacity(0.7),
              // ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context, "gallery");
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.image_sharp, color: Color.fromARGB(255, 238, 218, 39), size: 25),
                        MyText(left: 16, text: "Gallery", color2: Colors.black,fontSize: 20, fontWeight: FontWeight.w600)
                      ]
                    )
                  )
                )
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: paddingSize),
                    child: InkWell(
                    onTap: (){
                      Navigator.pop(context, "camera");
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt_outlined, color: Colors.green[300], size: 25,),
                        MyText(left: 16, text: "Camera", color2: Colors.black,fontSize: 20, fontWeight: FontWeight.w600)
                      ]
                    )
                  )
                )
              )
            ],
          ),
        );
      }
    );

    if (selected == 'camera'){
      label == null ? await getImage!(ImageSource.camera) : await getImage!(ImageSource.camera, label);
    } else if (selected == 'gallery'){
      label == null ? await getImage!(ImageSource.gallery) : await getImage!(ImageSource.gallery, label);
    }
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

  MyGradientButton({
    this.child,
    this.textButton,
    this.lsColor = const [ "#F27649", "#F28907" ],
    this.buttonColor = AppColors.third,
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
    // final isDarkTheme = Provider.of<ThemeProvider>(context).isDark;

    return Container(
      padding: edgePadding,
      margin: edgeMargin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [ AppServices().hexaCodeToColor(lsColor![0]), AppServices().hexaCodeToColor(lsColor![1]) ],
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