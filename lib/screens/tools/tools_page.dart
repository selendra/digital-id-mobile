import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/walletConnect_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/provider/digital_id_p.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/services/storage.dart';


class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  initState(){
    checkSession();
    // initDigitalId();
    initBlockchainData();
    super.initState();
  }

  initBlockchainData() async {
    await StorageServices.fetchData(DbKey.blochchainData).then((value) async {
      print("blochchainData $value");
      if (value != null){
        Provider.of<HomeProvider>(context, listen: false).setSuccessSubmitToBlockchain = true;
      } else {
        Provider.of<HomeProvider>(context, listen: false).setSuccessSubmitToBlockchain = false;
      }
      print("Provider.of<HomeProvider>(context, listen: false).successSubmitToBlockchain ${Provider.of<HomeProvider>(context, listen: false).successSubmitToBlockchain}");
    });
  }

  /// For Check Identity Setup (National ID, Student)
  initDigitalId() async {
    print("initDigitalId");
    
    await Provider.of<DigitalIDProvider>(context, listen: false).fetchID();

    await StorageServices.fetchData(DbKey.sensitive).then((value) async {
      print("sensitive $value");
      if (value != null){

        Map<String, dynamic> data = await json.decode(Encryption().decryptAES(value));
        print("data ${data}");

        // _dashBoardM.name = data['name'] == "" || data['name'] == null ? "" : data['name'];
        // _dashBoardM.email = data['email'] == "" || data['email'] == null ? "" : data['email'];
        // _dashBoardM.dob = data['dob'] == "" || data['dob'] == null ? "" : data['dob'];
        // _dashBoardM.nationality = data['nationality'] == "" || data['nationality'] == null ? "" : data['nationality'];
        // _dashBoardM.phoneNum = data['phoneNum'] == "" || data['phoneNum'] == null ? "" : data['phoneNum'];
        // _dashBoardM.country = data['country'] == "" || data['country'] == null ? "" : data['country'];

        // _dashBoardM.nameController.text = data['name'] == "" || data['name'] == null ? "" : data['name'];
        // _dashBoardM.emailController.text = data['email'] == "" || data['email'] == null ? "" : data['email'];
        // _dashBoardM.dobController.text = data['dob'] == "" || data['dob'] == null ? "" : data['dob'];
        // _dashBoardM.nationalityController.text = data['nationality'] == "" || data['nationality'] == null ? "" : data['nationality'];
        // _dashBoardM.phoneNumController.text = data['phoneNum'] == "" || data['phoneNum'] == null ? "" : data['phoneNum'];
        // _dashBoardM.countryController.text = data['country'] == "" || data['country'] == null ? "" : data['country'];

        // _digitalIDProvider!.isAbleSubmitToBlockchain(context: context);
      }
      
    });
    setState(() { });
  }

  checkSession() async {
    print("checkSession");
    final pref = await SharedPreferences.getInstance();
    String? value = pref.getString("session");
    print("value $value");
    if (value != null){
      await Provider.of<WalletConnectComponent>(context, listen: false).connectToPreviousSession();
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return const AccountBody();
  }
}
