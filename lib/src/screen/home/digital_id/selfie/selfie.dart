import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/models/digital_id_m.dart';
import 'package:wallet_apps/src/provider/digital_id_p.dart';
import 'package:wallet_apps/src/screen/home/digital_id/selfie/body_selfie.dart';

class SelfieSide extends StatefulWidget {
  const SelfieSide({ Key? key}) : super(key: key);

  @override
  _IdentifierState createState() => _IdentifierState();
}

class _IdentifierState extends State<SelfieSide> {

  DigitalIDProvider? provider;

  Future pickImage(String? img, String? label) async {
    print("pickImage");
    print("img $img");
    print("label $label");
    try {
      // if (label == 'back'){
      //   widget.model!.backFaceImage = img;
      // } else {
        
      //   widget.model!.selfieImage = img;
      // }
      provider!.identifierModel!.selfieImage = img;
      provider!.identifierModel!.lsIDCard!.add(img!);

      setState(() { });
    } catch (e){
      print("Error pickImage $e");
    }
  }

  Future<void> submit() async{
    
    // MyDialog().dialogLoading(context);
    await Future.delayed( const Duration(seconds: 1), () async {

      // provider!.setSetup = true;
      // If Other Information Complete
      provider!.identifierModel!.completedSetpUpID = true;
      // provider!.notify();
      // await StorageServices.storeData(DigitalIDModel().toJson(provider!.identifierModel!), DbKey.idKey);
      
      // For Complete Setup Digital ID And Then Assign 
      // Provider.of<DigitalIDProvider>(context, listen: false).isAbleSubmitToBlockchain(context: context);

      // Navigator.pushAndRemoveUntil(
      //   context, 
      //   MaterialPageRoute(builder: (context) => Home()), 
      //   (route) => false
      // );
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    provider = Provider.of<DigitalIDProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelfieSideBody(model: provider!.identifierModel, pickImage: pickImage, submit: submit);
  }
}