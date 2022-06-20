import 'dart:developer';

import 'package:digital_id/screens/kyc/setup_kyc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/models/digital_id_m.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/provider/digital_id_p.dart';
import 'package:digital_id/screens/dashboard/account_linked.dart';
import 'package:digital_id/screens/dashboard/indentityInfo.dart';
import 'package:digital_id/services/services_s.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoardBody extends StatelessWidget {

  final DashBoardModel? dashModel;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final TabController? tabController;
  final Function? onTab;
  final Function? edit;
  final Function? pickImage;
  final Function? submitEdit;

  const DashBoardBody({ 
    Key? key, 
    this.scaffoldKey,
    required this.dashModel, 
    this.tabController,
    required this.onTab,
    required this.edit, 
    required this.pickImage, 
    required this.submitEdit 
  }) : super(key: key);

  final double tabBarHeight = 55;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
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
              onPressed: () => Navigator.pop(context),
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
                      colorBtn: whiteColor.withOpacity(0.06),
                      colorText: whiteColor,
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
        color: whiteColor.withOpacity(0.06),
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
                      SvgPicture.asset("assets/logos/selendra.svg", width: 20),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyText(
                      fontSize: 16,
                      text: 'seZt2QtqVN515CqU2YrsviLLJq9grYxY89ZNAbVqVkCkffnkf',
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      
                    },
                    icon: Icon(Iconsax.copy, color: whiteColor),
                  )
                ],
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

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Card(
              margin: EdgeInsets.all(0),
              color: whiteColor.withOpacity(0.06),
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
                              child: SvgPicture.asset("assets/logos/selendra.svg", width: 50)
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
                  color: HexColor('#FFD90F').withOpacity(0.3),
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