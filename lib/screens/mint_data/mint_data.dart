import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/screens/mint_data/body_mint_data.dart';

class MintData extends StatefulWidget {
  const MintData({ Key? key }) : super(key: key);

  @override
  State<MintData> createState() => _MintDataState();
}

class _MintDataState extends State<MintData> {

  String? _seed;

  void generateKey() async {
    print("generateKey");
    // print(mnemonicToEntropy('hello world yes nice'));

    // _registrationProvider = Provider.of<RegistrationProvider>(context, listen: false);
    
    // _registrationProvider!.usrName = "Rithy THUL";
    // _registrationProvider!.email = "rithythul@gmail.com";
    // _registrationProvider!.password = "123456";
    // _registrationProvider!.password = "123456";

    ApiProvider _apiProvider = Provider.of<ApiProvider>(context, listen: false);
    print("_apiProvider.getSdk.api.connectedNode ${_apiProvider.getSdk.api.connectedNode}");

    _seed = await _apiProvider.generateMnemonic();
    // if (_apiProvider.getSdk.api.keyring. == true){
      print(_seed);
      setState(() {
    //     // _seed = bip39.generateMnemonic();
      });
    // }
  }

  @override
  initState(){
    generateKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MintDataBody(
      seed: _seed
    );
  }
}