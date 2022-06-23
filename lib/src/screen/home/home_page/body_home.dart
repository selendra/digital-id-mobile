import 'dart:developer';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';
import 'package:wallet_apps/src/components/shimmer_c.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/provider/home_p.dart';
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
                print("Open drawer ${homePageModel!.globalKey!.currentState!.hasDrawer}");
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
            onPressed: (){

            },
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, widget){

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  _balanceCard(context),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: paddingSize),
                    child: MyText(
                      text: "Document",
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),

                  _idCard(context),

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
            )
          );
        }
      )
    );
  }

 
  Widget _balanceCard(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: hexaCodeToColor(AppColors.whiteColor).withOpacity(0.06),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: 'Wallet',
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
              SizedBox(height: paddingSize,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/SelendraCircle-Blue.png", width: 20),
                      const SizedBox(width: 5,),
                      MyText(
                        fontSize: 16,
                        text: 'SEL',
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                  MyText(
                    fontSize: 16,
                    text: '0.0',
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
              SizedBox(height: paddingSize,),
              Consumer<ApiProvider>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: WidgetShimmer(
                          txt: value.accountM.address, 
                          child: MyText(
                            right: 5,
                            text: value.accountM.address == null ? "" : value.accountM.address!.replaceRange(10, value.accountM.address!.length - 10, "....."),
                            color: AppColors.whiteColorHexa,
                            fontSize: 16,
                            textAlign: TextAlign.left
                          )
                        )
                      ),
                      IconButton(
                        onPressed: (){
                          
                        },
                        icon: Icon(Iconsax.copy, color: hexaCodeToColor(AppColors.whiteColor)),
                      )
                    ],
                  );
                }
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _idCard(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, Transition(child: IdDetail(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Card(
              margin: EdgeInsets.all(0),
              color: hexaCodeToColor(AppColors.whiteColor).withOpacity(0.06),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text: 'ID: 000000000',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                    SizedBox(height: paddingSize,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: SvgPicture.asset("assets/male_avatar.svg", width: 50)
                            ),
                            const SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    MyText(
                                      fontSize: 14,
                                      text: 'Name: ',
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                    ),
                                    MyText(
                                      fontSize: 14,
                                      text: 'Sam Allen',
                                      color: AppColors.whiteColor,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    MyText(
                                      fontSize: 14,
                                      text: 'Date Of Birth: ',
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                    ),
                                    MyText(
                                      fontSize: 14,
                                      text: '09.02.2000',
                                      color: AppColors.whiteColor,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        fontSize: 14,
                                        text: 'Address: ',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                      ),
                                      Expanded(
                                        child: MyText(
                                          fontSize: 14,
                                          textAlign: TextAlign.start,
                                          // width: MediaQuery.of(context).size.width / 1.5,
                                          text: 'Tik L`lork, Toul Kork, Phnom Penh',
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  color: hexaCodeToColor('#FFD90F').withOpacity(0.3),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                child: MyText(
                  text: 'Verifying',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: "#FFD90F",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}