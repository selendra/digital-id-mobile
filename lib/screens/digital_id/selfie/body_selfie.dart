import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/camera_c.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/main.dart';
import 'package:digital_id/models/digital_id_m.dart';
import 'package:digital_id/components/success.dart';
import 'package:digital_id/services/services_s.dart';

import '../build_dot_indecator.dart';

class SelfieSideBody extends StatelessWidget {

  final DigitalIDModel? model;
  final Function? pickImage;
  final Function? submit;

  const SelfieSideBody({ Key? key, this.model, this.pickImage, this.submit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom("Selfie With Front Side", context, centerTitle: true),  
      body: Stack(
        children: [

          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Hint To upload Card
                // Card(
                //   margin: EdgeInsets.all(paddingSize),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     padding: EdgeInsets.all(paddingSize),
                //     child: Column(
                //       children: [
                //         MyText(
                //           width: 300,
                //           bottom: paddingSize,
                //           text: "Please submit a valid issued ${model!.title}}, with your face"
                //         ),

                //         MyText(
                //           width: 300,
                //           bottom: paddingSize,
                //           text: "Both Front and Back ${model!.title}."
                //         ),

                //         // Front
                //         model!.selfieImage != '' ? MyText(
                //           text: "Front"
                //         ) : Container(),
                //         Card(
                //           child: model!.selfieImage == '' ? Container(
                //             width: 400,
                //             height: MediaQuery.of(context).size.width/2.5,
                //             child: Image.asset(AppConfig.illusPath+"face.jpg")
                //           ) : Image.file(File(model!.selfieImage!), height: 200, width: 400),
                //         ),

                //         // Back
                //         model!.backFaceImage != '' ? MyText(
                //           text: "Back"
                //         ) : Container(),
                //         model!.backFaceImage == '' ? Container( ) : Card(child: Image.file(File(model!.backFaceImage!), height: 200, width: 400))
                //       ],
                //     ),
                //   ),
                // ),
                model!.selfieImage == ''
                ? Container(
                    width: 400,
                    height: MediaQuery.of(context).size.width / 2.5,
                    child: Image.asset(AppConfig.illusPath+"front_side_id.jpg")
                )
                : Image.file(
                    File(model!.selfieImage!),
                    height: 200,
                    width: 400,
                  ),

                MyText(
                  top: paddingSize,
                  bottom: paddingSize,
                  width: 311,
                  fontWeight: FontWeight.bold,
                  text: "Position your document inside the frame. Make sure that all the data is clearly visible."
                ),

                Padding(
                  padding: EdgeInsets.all(paddingSize),
                  child: TextButton(
                    child: MyText(
                      fontWeight: FontWeight.bold,
                      text: "Take a selfie"
                    ),
                    onPressed: () async {
                      try {

                        XFile img = await Navigator.push(context, MaterialPageRoute(builder: (context) => CameraApp()));

                        // final pickedFile = await ;
                        print("Selfie ${img}");
                        if (img != null){
                          await pickImage!(img.path, 'front');
                        }
                        // if (model!.selfieImage == ''){
                        // } else {
                        //   await pickImage!(pickedFile, 'back');
                        // }
                      } catch (e){
                        print("Error $e");
                      }
                    }
                  ),
                )
              ],
            ),
          ),
          const ReuseDotIndecator(indexPoint: 2),
          Positioned(
            left: paddingSize,
            right: paddingSize,
            bottom: paddingSize,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              onPressed: model!.selfieImage == '' ? null : () async {
                // MaterialPageRoute(builder: (context) => SuccessSubmit(method: () async {await submit!();},))
                Navigator.push(
                  context, 
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: SuccessSubmit(method: () async {await submit!();},)
                  )
                );
              }, 
              child: Container(
                height: btnHeight,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14)
                ),
                alignment: Alignment.center,
                child: MyText(
                  text: "Next Step", color2: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              )
            ),
          )
        ],
      ),
    );
  }
}