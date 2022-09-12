import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/provider/digital_id_p.dart';
import 'package:wallet_apps/src/screen/home/digital_id/back_side/body_back_side.dart';

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