import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
// import 'package:bip39/bip39.dart' as bip39;
import 'package:mnemonic/mnemonic.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/provider/registration_p.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  _CreateWalletPagetScreenState createState() => _CreateWalletPagetScreenState();
}

class _CreateWalletPagetScreenState extends State<CreateWalletPage> {
  bool initial = true;
  String _seed = '';
  RegistrationProvider? _registrationProvider;

  void generateKey() async {
    // print(mnemonicToEntropy('hello world yes nice'));

    // _registrationProvider = Provider.of<RegistrationProvider>(context, listen: false);
    
    // _registrationProvider!.usrName = "Rithy THUL";
    // _registrationProvider!.email = "rithythul@gmail.com";
    // _registrationProvider!.password = "123456";
    // _registrationProvider!.password = "123456";

    _seed = await Provider.of<ApiProvider>(context, listen: false).generateMnemonic();
    setState(() {
      // _seed = bip39.generateMnemonic();
    });
  }

  @override
  void didChangeDependencies() async {
    if (initial) {
      // _seed = bip39.generateMnemonic();

      setState(() {
        initial = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    generateKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreateKeyBody(
      initial: initial,
      seed: _seed,
      generateKey: generateKey,
    );
  }
}
