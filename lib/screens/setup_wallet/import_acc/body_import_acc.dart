import 'package:flutter/material.dart';
import 'package:digital_id/all_export.dart';

class ImportAccountBody extends StatelessWidget {
  final TextEditingController verifyInputController;
  final GlobalKey<FormState> formKey;
  final Function? validateSeed;
  final Function? submitSeed;

  const ImportAccountBody({ 
    Key? key, 
    required this.verifyInputController,
    required this.formKey,
    this.validateSeed,
    this.submitSeed,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SizedBox(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    selLogo(context),
                    const SizedBox(height: 20),
                    const Text('Import account',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2.5,
                      child: Text(
                        'Please input your account with your mnemonic or pass phrase.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                        )
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyInput(
                      label: 'Mnemonic', 
                      textEditingController: verifyInputController, 
                      validator: (String value) async {
                      },
                      onChanged: (String value) async {
                        await validateSeed!(value);
                      },
                    ),
                    const SizedBox(height: 25),
                    SubmitButton(
                      text: 'Import',
                      onPressed: () async {
                        await submitSeed!();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}