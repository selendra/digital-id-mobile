import 'package:flutter/material.dart';
import 'package:digital_id/all_export.dart';

class StoragesPageBody extends StatelessWidget {
  const StoragesPageBody({ Key? key }) : super(key: key);

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
              const StoragesInfo(),
              AddButton(
                text: 'Add Services', 
                onPressed: () {}
              ),
            ],
          ),
        ),
      ),
    );
  }
}