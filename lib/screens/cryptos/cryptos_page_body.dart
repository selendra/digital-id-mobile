import 'package:flutter/material.dart';
import 'package:digital_id/all_export.dart';

class CryptosPageBody extends StatelessWidget {
  const CryptosPageBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              profileWidget(context, pickImage: (){}, model: DashBoardModel()),
              const DashboardOptions(),
              titleDashboard('Cryptos Assets', context),
              const CryptosAssetInfo(),
              AddButton(
                text: 'Add Asset',
                onPressed: () {}
              ),
            ],
          ),
        ),
      ),
    );
  }
}