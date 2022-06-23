import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/camera_c.dart';
import 'package:digital_id/components/components_c.dart';
import 'package:digital_id/models/digital_id_m.dart';
import 'package:digital_id/provider/digital_id_p.dart';
import 'package:digital_id/screens/digital_id/back_side/body_back_side.dart';
import 'package:digital_id/screens/digital_id/front_side/body_front_side.dart';

class BackSide extends StatefulWidget {

  const BackSide({ Key? key}) : super(key: key);

  @override
  _BackSideState createState() => _BackSideState();
}

class _BackSideState extends State<BackSide> {

  DigitalIDProvider? _provider;
  
  Future pickImage(String? img, String? label) async {
    try {
      _provider!.identifierModel!.backImage = img;
      _provider!.identifierModel!.lsIDCard!.add(img!);
      // if (label == 'back'){
      // }
      //  else {
        
      //   _provider!.identifierModel!.frontImage = img;
      // }
      setState(() { });
    } catch (e){
      print("Error pickImage $e");
    }
  }
  @override
  void initState() {
    _provider = Provider.of<DigitalIDProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackSideBody(model: _provider!.identifierModel, pickImage: pickImage);
  }
}