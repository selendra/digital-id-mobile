

import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/provider/digital_id_p.dart';

class FrontSide extends StatefulWidget {

  const FrontSide({ Key? key}) : super(key: key);

  @override
  _FrontSideState createState() => _FrontSideState();
}

class _FrontSideState extends State<FrontSide> {

  DigitalIDProvider? _provider;
  
  Future pickImage(String? img, String? label) async {

    _provider!.identifierModel!.lsIDCard = [];
    try {
    // if (label == 'back'){
    //   _provider!.identifierModel!.backImage = img;
    // } else {
      
    // }
        _provider!.identifierModel!.frontImage = img;
        _provider!.identifierModel!.lsIDCard!.add(img!);
      setState(() { });
    } catch (e){
      print("Error pickImage $e");
    }
  }
  @override
  void initState() {
    _provider = Provider.of<DigitalIDProvider>(context, listen: false);
    _provider!.identifierModel!.lsIDCard = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FrontSideBody(model: _provider!.identifierModel, pickImage: pickImage);
  }
}