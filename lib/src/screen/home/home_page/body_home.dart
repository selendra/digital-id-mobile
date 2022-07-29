import 'dart:developer';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/cards/org_card_c.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';
import 'package:wallet_apps/src/components/document_card_c.dart';
import 'package:wallet_apps/src/components/scroll_speed.dart';
import 'package:wallet_apps/src/components/shimmer_c.dart';
import 'package:wallet_apps/src/models/digital_id_m.dart';
import 'package:wallet_apps/src/models/kyc_content_m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/provider/home_p.dart';
import 'package:wallet_apps/src/screen/home/assets/assets.dart';
import 'package:wallet_apps/src/screen/home/id_detail/id_detail.dart';
import 'package:wallet_apps/src/screen/home/kyc/setup_kyc.dart';

class HomeBody extends StatelessWidget {

  final HomePageModel? homePageModel;
  final bool? pushReplacement;
  final CTypeModel? cTypeModel;
  final Function(int index)? onPageChanged;
  final Function? queryCType;
  final TabController? tabBarController;
  final Color? selectedColor;
  final Function? scanLogin;

  const HomeBody({ 
    Key? key, 
    this.homePageModel,
    this.onPageChanged,
    this.pushReplacement,
    this.cTypeModel,
    this.queryCType,
    this.tabBarController,
    this.selectedColor,
    this.scanLogin,
  }) : super(key: key);

  final double tabBarHeight = 55;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homePageModel!.globalKey!,
      resizeToAvoidBottomInset: false,
      backgroundColor: hexaCodeToColor(AppColors.bgColor),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: Menu(),
      ),
      appBar: AppBar(
        backgroundColor: hexaCodeToColor(AppColors.bgColor),
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(
        //     Iconsax.profile_circle,
        //     color: Colors.white,
        //   ),
        //   onPressed: () => {
            
        //   },
        // ),
        leading: IconButton(
          icon: Icon(
            Iconsax.profile_circle,
            color: hexaCodeToColor(AppColors.secondary),
          ),
          onPressed: () {
            homePageModel!.globalKey!.currentState!.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Iconsax.scan,
                color: hexaCodeToColor(AppColors.secondary),
            ),
            onPressed: () async {
              await TrxOptionMethod().scanQR(
                context,
                [],
                pushReplacement!,
              ).then((value) async {
                print("TrxOptionMethod value $value");
                if (value != null){
                  await scanLogin!(value);
                }
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: MyBottomAppBar(
        index: homePageModel!.activeIndex,
        onIndexChanged: onPageChanged,
      ),
      body: PageView(
        // physics: CustomPageViewScrollPhysics(),
        controller: homePageModel!.pageController,
        onPageChanged: onPageChanged,
        children: [
          // DiscoverPage(homePageModel: homePageModel!),
      
          AssetsPage(homePageControl: homePageModel!.pageController,),
      
          Consumer<HomeProvider>(
            builder: (context, provider, widget){
        
              return Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: MyText(
                        //     textAlign: TextAlign.start,
                        //     text: "Other organization:",
                        //     fontSize: 18,
                        //     width: 55.w,
                        //   ),
                        // ),

                        // OrgCardComponent(),
                      
                        // if (KYCDocs().data.isEmpty)
                        //   Center(
                        //     child: MyText(
                        //       text: "No document has setup",
                        //       fontSize: 20,
                        //       width: 55.w,
                        //       color2: Colors.white,
                        //     ),
                        //   )                        
                        Container(
                          height: kToolbarHeight - 8.0,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TabBar(
                            controller: tabBarController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: selectedColor!.withOpacity(0.2),
                            ),
                            labelColor: selectedColor,
                            unselectedLabelColor: hexaCodeToColor("#D9D9D9"),
                            tabs: ["Pending", "Approved"].map((e) => Tab(
                              text: e,
                            )).toList(),
                          ),
                        ),

                        // TabBarView(
                        //   controller: tabBarController,
                        //   children: [
                        //     CustomButtonIcon(
                        //       onPressed: () async => {
                        //         Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpKYC()))
                        //       },
                        //       text: 'Pending',
                        //       icon: Icon(Iconsax.arrow_right_3),
                        //       colorBtn: hexaCodeToColor(AppColors.newPrimary),
                        //       colorText: hexaCodeToColor(AppColors.whiteColor),
                        //       bold: true,
                        //     ),

                        //     CustomButtonIcon(
                        //       onPressed: () async => {
                        //         Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpKYC()))
                        //       },
                        //       text: 'Approved',
                        //       icon: Icon(Iconsax.arrow_right_3),
                        //       colorBtn: hexaCodeToColor(AppColors.newPrimary),
                        //       colorText: hexaCodeToColor(AppColors.whiteColor),
                        //       bold: true,
                        //     ),


                        //     // for(int i = 0; i < KYCDocs().data.length; i++)
                        //     //   CardDocument(data: KYCDocs().data[i], isDetail: false,),
                      
                        //   ],
                        // ),

                        for(int i = 0; i < KYCDocs().data.length; i++)
                          CardDocument(data: KYCDocs().data[i], isDetail: false,),
                      
                        // if (KYCDocs().data.isEmpty)
                        //   SizedBox(height: paddingSize,),
                      
                        // CustomButtonIcon(
                        //   onPressed: () async => {
                        //     Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpKYC()))
                        //   },
                        //   text: 'Setup Document',
                        //   icon: Icon(Iconsax.arrow_right_3),
                        //   colorBtn: hexaCodeToColor(AppColors.newPrimary),
                        //   colorText: hexaCodeToColor(AppColors.whiteColor),
                        //   bold: true,
                        // ),

                      ],
                    ),
                  )
                ),
              );
            }
          ),
      
          Container()
      
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpKYC()));
        },
        child: Icon(Iconsax.add_circle, color: Colors.white, size: 9.w,),
        backgroundColor: hexaCodeToColor(AppColors.newPrimary),
      ),
    );
  }

}