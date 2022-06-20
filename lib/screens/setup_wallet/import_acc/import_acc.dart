import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/alert_dialog_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/provider/registration_p.dart';
import 'package:digital_id/screens/setup_wallet/import_acc/body_import_acc.dart';
import 'package:digital_id/services/storage.dart';
import 'package:encrypt/encrypt.dart';

class ImportAccount extends StatefulWidget {

  @override
  _ImportAccountState createState() => _ImportAccountState();
}

class _ImportAccountState extends State<ImportAccount> {

  final TextEditingController verifyInputController = TextEditingController();
  ApiProvider? _apiProvider;
  RegistrationProvider? _registerProvider;

  final formKey = GlobalKey<FormState>();

  Future<void> validateSeed(String mnemonic) async {
    bool? validate = await _apiProvider!.validateMnemonic(mnemonic);
    if (validate!){
      await submitSeed();
    }
  }

  Future<void> submitSeed() async {

    // Show Loading
    MyDialog().dialogLoading(context);

    try {

      await Provider.of<ApiProvider>(context, listen: false).addAcc(context: context, usrName: 'User name', password: _registerProvider!.password, seed: verifyInputController.text).then((value) async {

        // Encode Data
        Map<String, dynamic>? map = {
          'usrName': 'User name',
          'email': _registerProvider!.email,
          'password': _registerProvider!.password,
          'seed': verifyInputController.text
        };
        
        // Encrypt Data
        Encrypted _encrypted = Encryption().encryptAES(json.encode(map));
        await StorageServices.storeData(_encrypted.bytes, DbKey.sensitive);

        await MyDialog().customDialog(context, "Message", "Successfully import");
        
        // Navigator.pushNamedAndRemoveUntil(context, navbarRoute, (route) => false);
        await StorageServices.storeData(true, DbKey.login);
        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
      });
    } catch (e){
      print("Error submitSeed $e");
    }
      
  }

  @override
  void initState() {
    _apiProvider = Provider.of<ApiProvider>(context, listen: false);
    _registerProvider = Provider.of<RegistrationProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ImportAccountBody(
      verifyInputController: verifyInputController,
      formKey: formKey,
      validateSeed: validateSeed,
      submitSeed: submitSeed
    );
  }
}
