import 'dart:developer';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';
import 'package:wallet_apps/src/components/document_card_c.dart';
import 'package:wallet_apps/src/components/scroll_speed.dart';
import 'package:wallet_apps/src/components/shimmer_c.dart';
import 'package:wallet_apps/src/models/kyc_content_m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/provider/home_p.dart';
import 'package:wallet_apps/src/screen/home/assets/assets.dart';
import 'package:wallet_apps/src/screen/home/id_detail/id_detail.dart';
import 'package:wallet_apps/src/screen/home/kyc/setup_kyc.dart';

class HomeBody extends StatelessWidget {

  
  final HomePageModel? homePageModel;
  final bool? pushReplacement;
  final Function(int index)? onPageChanged;

  const HomeBody({ 
    Key? key, 
    this.homePageModel,
    this.onPageChanged,
    this.pushReplacement,
  }) : super(key: key);

  final double tabBarHeight = 55;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homePageModel!.globalKey!,
      resizeToAvoidBottomInset: false,
      backgroundColor: hexaCodeToColor(AppColors.darkBgd),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: Menu(),
      ),
      appBar: AppBar(
        backgroundColor: hexaCodeToColor(AppColors.darkBgd),
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(
        //     Iconsax.profile_circle,
        //     color: Colors.white,
        //   ),
        //   onPressed: () => {
            
        //   },
        // ),
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                Iconsax.profile_circle,
                color: Colors.white,
              ),
              onPressed: () {
                homePageModel!.globalKey!.currentState!.openDrawer();
              },
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Iconsax.scan,
              color: Colors.white,
            ),
            onPressed: () async {
              await TrxOptionMethod.scanQR(
                context,
                [],
                pushReplacement!,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: MyBottomAppBar(
        index: homePageModel!.activeIndex,
        onIndexChanged: onPageChanged,
      ),
      body: PageView(
        physics: CustomPageViewScrollPhysics(),
        controller: homePageModel!.pageController,
        onPageChanged: onPageChanged,
        children: [
      
          // DiscoverPage(homePageModel: homePageModel!),
      
          AssetsPage(homePageControl: homePageModel!.pageController,),
      
          Center(
            child: Consumer<HomeProvider>(
              builder: (context, provider, widget){
        
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        // _balanceCard(context),
                      
                        if (KYCDocs().data.isEmpty)
                          Center(
                            child: MyText(
                              text: "No document has setup",
                              fontSize: 20,
                              width: 55.w,
                              color2: Colors.white,
                            ),
                          )                        
                      
                        else for(int i = 0; i < KYCDocs().data.length; i++)
                          CardDocument(data: KYCDocs().data[i],),
                      
                        if (KYCDocs().data.isEmpty)
                          SizedBox(height: paddingSize,),
                      
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButtonIcon(
                            onPressed: () async => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpKYC()))
                            },
                            text: 'Setup Document',
                            icon: Icon(Iconsax.arrow_right_3),
                            colorBtn: hexaCodeToColor(AppColors.whiteColor).withOpacity(0.06),
                            colorText: hexaCodeToColor(AppColors.whiteColor),
                            bold: true,
                          ),
                        ),
                      ],
                    )
                  ),
                );
              }
            ),
          ),
      
          Container()
      
        ],
      ),
    );
  }

 
  // Widget _balanceCard(BuildContext context){
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Card(
  //       color: hexaCodeToColor(AppColors.whiteColor).withOpacity(0.06),
  //       elevation: 0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20)
  //       ),
  //       child: Container(
  //         width: MediaQuery.of(context).size.width,
  //         padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             MyText(
  //               text: 'Wallet',
  //               fontWeight: FontWeight.bold,
  //               color: AppColors.whiteColor,
  //             ),
  //             SizedBox(height: paddingSize,),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Image.asset("assets/SelendraCircle-Blue.png", width: 20),
  //                     const SizedBox(width: 5,),
  //                     MyText(
  //                       fontSize: 16,
  //                       text: 'SEL',
  //                       fontWeight: FontWeight.bold,
  //                       color: AppColors.whiteColor,
  //                     ),
  //                   ],
  //                 ),
  //                 MyText(
  //                   fontSize: 16,
  //                   text: '0.0',
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColors.whiteColor,
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: paddingSize,),
  //             Consumer<ApiProvider>(
  //               builder: (context, value, child) {
  //                 return Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Expanded(
  //                       child: WidgetShimmer(
  //                         txt: value.accountM.address, 
  //                         child: MyText(
  //                           right: 5,
  //                           text: value.accountM.address == null ? "" : value.accountM.address!.replaceRange(10, value.accountM.address!.length - 10, "....."),
  //                           color: AppColors.whiteColorHexa,
  //                           fontSize: 16,
  //                           textAlign: TextAlign.left
  //                         )
  //                       )
  //                     ),
  //                     IconButton(
  //                       onPressed: (){
                          
  //                       },
  //                       icon: Icon(Iconsax.copy, color: hexaCodeToColor(AppColors.whiteColor)),
  //                     )
  //                   ],
  //                 );
  //               }
  //             ),
              
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}