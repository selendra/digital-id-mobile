import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/models/digital_id_m.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/provider/digital_id_p.dart';
import 'package:digital_id/screens/home/account_linked.dart';
import 'package:digital_id/screens/home/indentityInfo.dart';
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
      backgroundColor: whiteColor,
      body: Consumer<HomeProvider>(
        builder: (context, provider, widget){
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  ClipRRect(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
                    child: profileWidget(context, model: dashModel, pickImage: pickImage)
                  ),

                  TabBar(
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    onTap: (index){
                      onTab!(index);
                    },
                    tabs: [
                      
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Consumer<HomeProvider>(
                          builder: (context, provider, widget){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(
                                  width: tabBarHeight,
                                  height: tabBarHeight,
                                  child: Stack(
                                    children: [

                                      Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(AppConfig.iconPath+"profile3.svg", width: 40, height: 34, color: tabController!.index == 0 ? Colors.black : greyColor,),
                                      ),

                                      provider.successSubmitToBlockchain
                                      ? Positioned(
                                        child: Image.asset(AppConfig.iconPath+"check.png", width: 20),
                                        right: 0,
                                        bottom: 0
                                      ) 
                                      : Container()
                                    ],
                                  ),
                                ),
                                MyText(
                                  fontSize: 16,
                                  text: provider.successSubmitToBlockchain ? 'Verified' : 'Verify',
                                  color2: tabController!.index == 0 ? Colors.black : greyColor, 
                                  fontWeight: tabController!.index == 0 ? FontWeight.bold : FontWeight.w600
                                )
                              ],
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: tabBarHeight,
                              child: Icon(Icons.qr_code_2_outlined, size: 40, color: tabController!.index == 1 ? Colors.black : greyColor,),
                            ),
                            MyText(
                              fontSize: 16,
                              text: 'Wallet ID',
                              color2: tabController!.index == 1 ? Colors.black : greyColor, 
                              fontWeight: tabController!.index == 1 ? FontWeight.bold : FontWeight.w600
                            )
                          ],
                        )
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: tabBarHeight,
                              child: Icon(Icons.contact_page_outlined, size: 40, color: tabController!.index == 2 ? Colors.black : greyColor,)
                            ),
                            MyText(
                              fontSize: 16,
                              text: 'Accounts',
                              color2: tabController!.index == 2 ? Colors.black: greyColor, 
                              fontWeight: tabController!.index == 2 ? FontWeight.bold : FontWeight.w600
                            )
                          ],
                        ),
                      )

                    ]
                  ),

                  titleDashboard(
                    dashModel!.titlePage, 
                    context, 
                    title2: tabController!.index == 0 ? InkWell(
                      onTap: (){
                        edit!();
                      }, 
                      child: MyText(text: dashModel!.isEditing ? "Un-do" : "Edit", fontWeight: FontWeight.bold, textAlign: TextAlign.right, right: paddingSize, color2: Colors.blue,)
                    ) : Container()
                  ),

                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 1.1,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        PersonlInfo(model: dashModel, edit: edit, submitEdit: submitEdit),
                        IdentityInfo(dashBoardModel: dashModel, submitEdit: edit),
                        AccountLinked(),
                      ]
                    ),
                  )
                ],
              )
            )
          );
        }
      )
    );
  }
}