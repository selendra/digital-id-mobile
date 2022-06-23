import 'dart:developer';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/provider/home_p.dart';
import 'package:wallet_apps/src/screen/home/kyc/setup_kyc.dart';

class DashBoardBody extends StatelessWidget {

  final DashBoardModel? dashModel;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final TabController? tabController;
  final Function? onTab;
  final Function? edit;
  final Function? submitEdit;

  const DashBoardBody({ 
    Key? key, 
    this.scaffoldKey,
    required this.dashModel, 
    this.tabController,
    required this.onTab,
    required this.edit, 
    required this.submitEdit 
  }) : super(key: key);

  final double tabBarHeight = 55;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: hexaCodeToColor(AppColors.primaryColor),
      appBar: AppBar(
        backgroundColor: hexaCodeToColor(AppColors.primaryColor),
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
                      colorBtn: hexaCodeToColor(AppColors.whiteColor).withOpacity(0.06),
                      colorText: hexaCodeToColor(AppColors.whiteColor),
                      bold: true,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<DocumentProvider>(
                      builder: (context, provider, widget){
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.lsMandotaryProp!.length,
                          itemBuilder: ((context, index) {
                            return TextFormField(
                              keyboardType: provider.lsMandotaryProp![index]['type'] == 'integer' ? TextInputType.number : TextInputType.text,
                              controller: provider.lsMandotaryProp![index]['formController'],
                              decoration: InputDecoration(
                                
                                hintText: provider.lsMandotaryProp![index]['key']
                              ),
                            );
                          })
                        );
                      },
                    ),
                  ),

                  Divider(height: 2,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<DocumentProvider>(
                      builder: (context, provider, widget){
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.lsPopularProp!.length,
                          itemBuilder: ((context, index) {
                            return TextFormField(
                              keyboardType: provider.lsPopularProp![index]['type'] == 'integer' ? TextInputType.number : TextInputType.text,
                              controller: provider.lsPopularProp![index]['formController'],
                              decoration: InputDecoration(
                                
                                hintText: provider.lsPopularProp![index]['key']
                              ),
                            );
                          })
                        );
                      },
                    ),
                  ),

                  Divider(height: 2,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<DocumentProvider>(
                      builder: (context, provider, widget){
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.lsIssuerProp!.length,
                          itemBuilder: ((context, index) {
                            return TextFormField(
                              keyboardType: provider.lsIssuerProp![index]['type'] == 'integer' ? TextInputType.number : TextInputType.text,
                              controller: provider.lsIssuerProp![index]['formController'],
                              decoration: InputDecoration(
                                
                                hintText: provider.lsIssuerProp![index]['key']
                              ),
                            );
                          })
                        );
                      },
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
                    icon: Icon(Iconsax.copy, color: hexaCodeToColor(AppColors.whiteColor)),
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