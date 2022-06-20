import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';
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