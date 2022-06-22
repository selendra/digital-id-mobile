import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/alert_dialog_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/provider/registration_p.dart';
import 'package:digital_id/screens/otp_verify/body_otp_verify_page.dart';
import 'package:digital_id/services/storage.dart';
import 'package:encrypt/encrypt.dart';

import '../../widgets/build_line_top.dart';
import '../../shared/bg_shared.dart';


class OTPVerifyPage extends StatefulWidget {

  @override
  _OTPVerifyPageState createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {

  final TextEditingController verifyInputController = TextEditingController();
  
  ApiProvider? _api;

  final formKey = GlobalKey<FormState>();
  
  String? _otp;

  void validator() async {
    final form = formKey.currentState!;

    // Show Loading
    MyDialog().dialogLoading(context);

    // if (form.validate()) {

      
    // }
  }

  void onChanged(String value) async {
    
    if (value.length == _otp!.length){

      await StorageServices.fetchData(DbKey.otpCode).then((otp) async {
        String decrypt = Encryption().decryptAES(otp);
        if (value == decrypt){
          MyDialog().dialogLoading(context);

          RegistrationProvider _registerProvider = Provider.of<RegistrationProvider>(context, listen: false);

          // Map<String, dynamic>? map = {
          //   'usrName': '',
          //   'email': _registerProvider.email,
          //   'password': _registerProvider.password,
          //   'seed': verifyInputController.text
          // };
          
          // // Encrypt Data
          // Encrypted _encrypted = Encryption().encryptAES(json.encode(map));
          // await StorageServices.storeData(_encrypted.bytes, DbKey.sensitive);
          // await _api!.autoGenerateAcc(context: context);

          Provider.of<HomeProvider>(context, listen: false).setWallet = _api!.accountM.address!;

          // await MyDialog().customDialog(context, "Message", "Successfully verify");
          await StorageServices.storeData(true, DbKey.login);

          // Auto Generate Account After Verify
          
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPage()), (route) => false);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const SetupPage()));
        } else {
          await MyDialog().customDialog(context, "Oops", "Incorrect code");
        }
      });
    }
  }

  @override
  void initState() {
    _api = Provider.of<ApiProvider>(context, listen: false);
    StorageServices.fetchData(DbKey.otpCode).then((otp) async {
      _otp = Encryption().decryptAES(otp);
    });
    
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OTPVerifyPageBody(
      verifyInputController: verifyInputController,
      formKey: formKey,
      onChanged: onChanged,
      validator: validator
    );
  }
}
