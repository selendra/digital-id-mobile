import 'package:flutter/material.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/main.dart';

class SetupPageBody extends StatelessWidget {
  const SetupPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(paddingSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Text('Wallet Setup',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Text('Import an existing wallet or create a new one.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: 'Create a new wallet',
                    colorBtn: primaryColor,
                    colorText: whiteColor,
                    onPressed: () => Navigator.pushNamed(context, createWalletRoute),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: 'Import secret phrase key',
                    colorBtn: whiteColor,
                    colorText: primaryColor,
                    onPressed: () => Navigator.pushNamed(context, importRoute),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
