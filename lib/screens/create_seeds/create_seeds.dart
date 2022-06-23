import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/custom_button.c.dart';
import 'package:digital_id/models/create_key_m.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/screens/create_seeds/body_create_key.dart';
import 'package:digital_id/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CreateSeeds extends StatefulWidget {

  const CreateSeeds({Key? key}): super(key: key);

  @override
  _CreateWalletPagetScreenState createState() =>
      _CreateWalletPagetScreenState();
}

class _CreateWalletPagetScreenState extends State<CreateSeeds> {
  
  final CreateKeyModel _model = CreateKeyModel();

  void generateKey() async {
    //"orient effort sea envelope voice lucky enforce expire tragic bring skull arrange";
    _model.seed = await Provider.of<ApiProvider>(context, listen: false).generateMnemonic();
    print(_model.seed);
    // Split Seed to list
    _model.lsSeeds = _model.seed!.split(" ");
    setState(() { });
  }

  void _showWarning(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: HexColor(AppColors.bluebgColor),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(paddingSize),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 2.5),
                MyText(
                  text: "Please, read carefully!",
                  fontSize: 18,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),  
        
        
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: HexColor("#FFF5F5"),
                  ), 
                  height: 75,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 1),
                      // SvgPicture.asset('assets/icons/warning.svg'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Lottie.asset(
                          "assets/animation/warning-shield.json",
                          repeat: true,
                        ),
                      ),
        
                      SizedBox(width: 2),
                      Expanded(
                        child: MyText(
                          text: "The information below is important to guarantee your account security.",
                          color: AppColors.warningColor,
                          textAlign: TextAlign.start,
                          fontSize: 12,
                        ),
                      )
                    ]
                  ),
                ),
        
                SizedBox(height: 5),
                MyText(
                  text: "Please write down your wallet's mnemonic seed and keep it in a safe place. The mnemonic can be used to restore your wallet. If you lose it, all your assets that link to it will be lost.",
                  textAlign: TextAlign.start,
                  color: AppColors.whiteColor,
                  fontSize: 14,
                ),
        
                SizedBox(height: 7),
                MyGradientButton(
                  textButton: "I Agree",
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  action: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  void didChangeDependencies() async {
    if (_model.initial == true) {

      setState(() {
        _model.initial = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _model.initial = true;
    StorageServices().readSecure(DbKey.passcode)!.then((value) => _model.passCode = value);
    generateKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWarning(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreateSeedsBody(
      createKeyModel: _model,
      generateKey: generateKey,
    );
  }
}
