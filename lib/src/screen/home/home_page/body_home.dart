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

  const HomeBody({ 
    Key? key, 
    this.homePageModel,
    this.onPageChanged,
    this.pushReplacement,
    this.cTypeModel,
    this.queryCType,
    this.tabBarController,
    this.selectedColor
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
        // physics: CustomPageViewScrollPhysics(),
        controller: homePageModel!.pageController,
        onPageChanged: onPageChanged,
        children: [
      
          AssetsPage(homePageControl: homePageModel!.pageController,),
      
          Consumer<DocumentProvider>(
            builder: (context, provider, widget){
        
              return provider.kycDocs.data.isNotEmpty ? Column(
                children: [ 

                  Container(
                    height: kToolbarHeight - 8.0,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: paddingSize, right: paddingSize, bottom: paddingSize, top: paddingSize),
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

                  Expanded(
                    child: TabBarView(
                      controller: tabBarController,
                      children: [

                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.kycDocs.pending.length,
                          itemBuilder: (context, index){
                            return CardDocument(data: provider.kycDocs.pending[index], isDetail: false,);
                          }
                        ),

                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.kycDocs.approve.length,
                          itemBuilder: (context, index){
                            return CardDocument(data: provider.kycDocs.approve[index], isDetail: false,);
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              ) 
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset(AppConfig.logoPath+"document.png", width: 178, height: 178,),
                  
                  MyText(
                    top: 20.sp,
                    text: "Empty list",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),

                  MyText(
                    top: 15.sp,
                    text: "No document has found",
                    bottom: 30.sp,
                  ),

                  MyFlatButton(
                    height: 33.sp,
                    edgeMargin: EdgeInsets.symmetric(horizontal: paddingSize),
                    textButton: "Setup Selendra ID",
                    // textColor: AppColors.whiteColor,
                    buttonColor: AppColors.newPrimary,
                    action: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }
          ),
      
          Container()
      
        ],
      ),

      floatingActionButton: Consumer<DocumentProvider>(
        builder: (context, provider, widget){
          
          return provider.kycDocs.data.isNotEmpty ? FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpKYC()));
            },
            child: Icon(Iconsax.add_circle, color: Colors.white, size: 9.w,),
            backgroundColor: hexaCodeToColor(AppColors.newPrimary),
          ) : Container();
        }
      ),
    );
  }

}