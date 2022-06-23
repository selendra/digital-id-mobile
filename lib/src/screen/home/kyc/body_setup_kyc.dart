import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/component.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: MyText(
          text: "Documents Type",
          color: AppColors.whiteColorHexa,
        ),
      ),
      body: Consumer<DocumentProvider>(
        builder: (context, provider, widget){
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize,),
                  child: MyText(
                    text: 'Mandatory',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColorHexa,
                  ),
                ),
          
                _mandatory(context, provider.lsMandotaryProp!),
                
                SizedBox(height: paddingSize),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize),
                  child: MyText(
                    text: 'Popular document',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColorHexa,
                  ),
                ),
          
                _popularDocs(context, isShowMorePopularDocs!, provider.lsPopularProp!), //!),
          
                SizedBox(height: paddingSize),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize),
                  child: MyText(
                    text: 'Issuer',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColorHexa,
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
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: CustomButtonIcon(
        onPressed: () async {
          Provider.of<DocumentProvider>(context, listen: false).title = 'National ID';
          createIDBottomSheet(context, ls);
        },
        text: 'National ID',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),
    );
  }

  Widget _popularDocs(BuildContext context, bool _isShowMorePopularDocs, List<dynamic> ls) {
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

          CustomButton(
            colorBtn: Colors.white.withOpacity(0.06),
            text: _isShowMorePopularDocs == false ? "Show More" : "Show Less",
            onPressed: () {
              onShowMorePopularDocs!();
            }
          ),
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

          CustomButton(
            colorBtn: Colors.white.withOpacity(0.06),
            text: _isShowMoreIssuer == false ? "Show More" : "Show Less",
            onPressed: () {
              onShowMoreIssuer!();
            }
          ),
        ],
      ),
    );
  }

}