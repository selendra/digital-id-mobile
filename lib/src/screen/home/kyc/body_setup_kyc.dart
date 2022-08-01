import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/component.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';
import 'package:wallet_apps/src/models/kyc_content_m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/theme/color.dart';

class SetUpKYCBody extends StatelessWidget {

  final bool? isShowMorePopularDocs;
  final bool? isShowMoreIssuer;
  final Function? onShowMorePopularDocs;
  final Function? onShowMoreIssuer;

  const SetUpKYCBody({
    Key? key,
    this.isShowMorePopularDocs,
    this.isShowMoreIssuer,
    this.onShowMorePopularDocs,
    this.onShowMoreIssuer
  }) : super(key: key);

  final double titleSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: MyText(
          textAlign: TextAlign.left,
          text: "Documents Type",
          fontSize: 18,
          color: AppColors.newText,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Consumer<DocumentProvider>(
        builder: (context, provider, widget){
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                SizedBox(height: paddingSize),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize,),
                  child: MyText(
                    text: 'Mandatory',
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.newText,
                  ),
                ),
          
                _mandatory(context, provider.lsMandotaryProp!),
                
                SizedBox(height: paddingSize),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize),
                  child: MyText(
                    text: 'Popular document',
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.newText,
                  ),
                ),
          
                _popularDocs(context, isShowMorePopularDocs!, provider.lsPopularProp!), //!),
          
                SizedBox(height: paddingSize),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize),
                  child: MyText(
                    text: 'Issuers',
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.newText,
                  ),
                ),
          
                _issuer(context, isShowMoreIssuer!, provider.lsIssuerProp!),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _mandatory(BuildContext context, List<dynamic> ls) {
    final _random = Random();
    return GestureDetector(
      onTap: () async{
        Provider.of<DocumentProvider>(context, listen: false).title = 'National ID';
        MyBottomSheet().createIDBottomSheet(context, ls);
      },
      child: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: hexaCodeToColor(AppColors.blue),
              color: Colors.primaries[_random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100],
            ),
            padding: EdgeInsets.only(top: 1, bottom: 5, left: 1, right: 1,),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: hexaCodeToColor(AppColors.newCard),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(paddingSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      child: SvgPicture.asset("assets/logo/national-id.svg"),
                    ),
                    MyText(
                      top: 2.h,
                      text: "National ID",
                      fontSize: 16,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _popularDocs(BuildContext context, bool _isShowMorePopularDocs, List<dynamic> ls) {
    // return GestureDetector(
    //   onTap: () async{
    //     Provider.of<DocumentProvider>(context, listen: false).title = 'National ID';
    //     MyBottomSheet().createIDBottomSheet(context, ls);
    //   },
    //   child: Padding(
    //     padding: EdgeInsets.all(paddingSize),
    //     child: Center(
    //       child: Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(20),
    //           color: hexaCodeToColor(AppColors.newCard),
    //         ),
    //         width: MediaQuery.of(context).size.width,
    //         child: Padding(
    //           padding: EdgeInsets.all(paddingSize),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               SvgPicture.asset("assets/logo/national-id.svg"),
    //               MyText(
    //                 top: 2.h,
    //                 text: "National ID",
    //                 fontSize: 16,
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: Column(
        children: [
          AnimatedSize(
            curve: _isShowMorePopularDocs == true ? Curves.easeIn : Curves.easeOut,
            duration: const Duration(milliseconds: 300),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _isShowMorePopularDocs == false ? 3 : KYCDocs.lsPopularDocs!.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KYCDocs.lsPopularDocs![index],
                    ],
                  ),
                );
              }
            ),
          ),

          MyFlatButton(
            isTransparent: true,
            textColor: AppColors.newPrimary,
            textButton:  _isShowMorePopularDocs == false ? "Show More" : "Show Less",
            buttonColor: AppColors.newPrimary,
            action: (){
              onShowMorePopularDocs!();
            }
          )
          
        ],
      ),
    );
  }

  Widget _issuer(BuildContext context, bool _isShowMoreIssuer, List<dynamic> ls) {
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: Column(
        children: [
          AnimatedSize(
            curve: _isShowMoreIssuer == true ? Curves.easeIn : Curves.easeOut,
            duration: const Duration(milliseconds: 300),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _isShowMoreIssuer == false ? 2 : KYCDocs.lsIssuer!.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KYCDocs.lsIssuer![index],
                    ],
                  ),
                );
              }
            ),
          ),

          MyFlatButton(
            isTransparent: true,
            textColor: AppColors.newPrimary,
            textButton: _isShowMoreIssuer == false ? "Show More" : "Show Less",
            buttonColor: AppColors.newPrimary,
            action: (){
              onShowMoreIssuer!();
            }
          )
        ],
      ),
    );
  }

}