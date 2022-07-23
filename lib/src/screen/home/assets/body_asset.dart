import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/asset_item_c.dart';
import 'package:wallet_apps/src/components/category_card_c.dart';
import 'package:wallet_apps/src/components/menu_item_c.dart';
import 'dart:math';
import 'package:wallet_apps/src/components/pie_chart.dart';
import 'package:wallet_apps/src/components/shimmer_c.dart';
class AssetsPageBody extends StatelessWidget {
  final AssetPageModel? model;
  final Function? onTapCategories;
  final Function? onHorizontalChanged;

  const AssetsPageBody({ 
    Key? key,
    this.onTapCategories,
    this.model,
    this.onHorizontalChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   titleSpacing: 0,
      //   title: MyText(text: "Assets", color2: Colors.white, fontSize: 17),
      //   backgroundColor: hexaCodeToColor(AppColors.bluebgColor),
      //   elevation: 0,
      // ),
      body: BodyScaffold(
        physic: BouncingScrollPhysics(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        isSafeArea: true,
        bottom: 0,
        child: Column(
          children: [
            
            // _userWallet(context),
            _balanceCard(context),
      
            Padding(
              padding: const EdgeInsets.all(paddingSize),
              child: SizedBox(
                height: 30.sp,
                child: categoryToken()
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingSize),
              child: Row(
                children: [
                  MyText(
                    text: "Assets",
                    // text: "Selendra Network",
                    color: AppColors.titleAssetColor,
                    fontWeight: FontWeight.w500
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: hexaCodeToColor(AppColors.titleAssetColor),
                      indent: 2.w,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: model!.tabController,
                children: [
            
                  _selendraNetworkList(context, Provider.of<ContractProvider>(context).sortListContract),
                  _selendraNetworkList(context, model!.nativeAssets!, ),
                  _selendraNetworkList(context, model!.bep20Assets  !, networkIndex: 2),
                  _selendraNetworkList(context, model!.erc20Assets!, networkIndex: 3)
                ]
              ),
            )

            // SizedBox(height: 25),

            // _otherNetworkList(context),
          ],
        ),
      ),
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
              
              SizedBox(height: 3.h),
              _operationRequest(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userWallet(BuildContext context) {

    return Consumer<ApiProvider>(
      builder: (context, apiProvider, widget){

        return Container(
          decoration: BoxDecoration(
            color: hexaCodeToColor(AppColors.bluebgColor),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              
              // PieChartSample1(),

              // PieChartSample2(),

              // PieChartSample3(),

              // if(apiProvider.accountM.addressIcon == null)
              // Shimmer.fromColors(
              //   child: Container(
              //     width: 60,
              //     height: 60,
              //     margin: EdgeInsets.only(bottom: 3),
              //     decoration: BoxDecoration(
              //       color: hexaCodeToColor(AppColors.sliderColor),
              //       shape: BoxShape.circle,
              //       // boxShadow: [
              //       //   BoxShadow(color: Colors.white, blurRadius: 20.0),
              //       // ],
              //     ),
              //   ), 
              //   period: const Duration(seconds: 2),
              //   baseColor: hexaCodeToColor(AppColors.sliderColor),
              //   highlightColor: hexaCodeToColor(AppColors.whiteColorHexa),
              // ) 
              // else Container(
              //   width: 60,
              //   height: 60,
              //   margin: const EdgeInsets.only(right: 5),
              //   decoration: BoxDecoration(
              //     color: hexaCodeToColor(AppColors.sliderColor),
              //     shape: BoxShape.circle,
              //     boxShadow: [
              //       BoxShadow(color: Colors.white, blurRadius: 10.0),
              //     ],
              //   ),
              //   child: SvgPicture.string(apiProvider.accountM.addressIcon!),
              // ),

              // SizedBox(height: 2.h),
              // if(apiProvider.accountM.addressIcon == null)
              // Shimmer.fromColors(
              //   child: Container(
              //     width: 100,
              //     height: 8.0,
              //     margin: EdgeInsets.only(bottom: 3),
              //     color: Colors.white,
              //   ), 
              //   period: const Duration(seconds: 2),
              //   baseColor: hexaCodeToColor(AppColors.sliderColor),
              //   highlightColor: hexaCodeToColor(AppColors.whiteColorHexa),
              // )
              // else MyText(
              //   bottom: 3,
              //   text: apiProvider.accountM.name ?? '',
              //   color: AppColors.whiteColorHexa,
              //   fontSize: 20.sp,
              // ),

              SizedBox(height: 2.h),
              Consumer<ContractProvider>(
                builder: (context, provider, widget){
                  return MyText(
                    text: "\$ ${ (provider.mainBalance).toStringAsFixed(2) }",
                    color: AppColors.whiteColorHexa,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  );
                }
              ),
              
              SizedBox(height: 2.h),
              Consumer<ContractProvider>(
                builder: (context, provider, widget){
                  return MyText(
                    text: provider.listContract.isEmpty ? '' : """≈ ${ (provider.mainBalance / double.parse(provider.listContract[apiProvider.btcIndex].marketPrice ?? '0')).toStringAsFixed(5) } BTC""",
                    color: AppColors.tokenNameColor,
                    fontWeight: FontWeight.bold,
                  );
                }
              ),

              SizedBox(height: 3.h),
              _operationRequest(context),
            ],
          ),
        );
      } 
    );
  }

  Widget _selendraNetworkList(BuildContext context, List<SmartContractModel> lsAsset, {int? networkIndex}){
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        print("onHorizontalChanged ${details.primaryVelocity!.toDouble()}");
        onHorizontalChanged!(details);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingSize),
        child: Stack(
          children: [

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: lsAsset.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      Transition(
                        child: AssetInfo(
                          index: index,
                          scModel: lsAsset[index]
                        ),
                        transitionEffect: TransitionEffect.RIGHT_TO_LEFT
                      ),
                    );
                  },
                  child: AssetsItemComponent(
                    scModel: lsAsset[index]
                  )
                );
              }
            ),

            // if (lsAsset.isEmpty && )
            // Lottie.asset(AppConfig.animationPath+"no-data.json"),

            if (lsAsset.isEmpty && networkIndex != null) Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                SizedBox(
                  height: 60.sp,
                  child: OverflowBox(
                    minHeight: 60.h,
                    maxHeight: 60.h,
                    child: Lottie.asset(AppConfig.animationPath+"no-data.json", width: 60.w, height: 60.w),
                  )
                ),
                MyText(
                  text: "Don't see your token?",
                  color2: Colors.grey.shade400,
                  bottom: 10.sp,
                ),
            
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => AddAsset(network: networkIndex == 2 ? 0 : 1,))
                    );
                  },
                  child: MyText(
                    fontSize: 16,
                    text: "Import asset",
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    // left: 5.sp
                  )
                )
              ],
            )
          ]
        )
          
      )
      
    );
  }

  Widget _otherNetworkList(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingSize - 10),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                MyText(
                  text: "Other Network",
                  color: AppColors.titleAssetColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: hexaCodeToColor(AppColors.titleAssetColor),
                    indent: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _operationRequest(BuildContext context) {
    double width = 30.w;
    double height = 7.h;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        MyGradientButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              MyText(
                text: "Send",
                color: AppColors.whiteColorHexa,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          height: height,
          width: width,
          lsColor: ["#035A8F", "#035A8F"],
          begin: Alignment.bottomRight, 
          end: Alignment.topLeft, 
          action: (){
            Navigator.push(
              context, 
              Transition(child: SubmitTrx("", true, []), transitionEffect: TransitionEffect.RIGHT_TO_LEFT)
            );
          }
        ),

        SizedBox(width: 10,),
        
        MyGradientButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              MyText(
                text: "Receieve",
                color: AppColors.whiteColorHexa,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          height: height,
          width: width,
          lsColor: ["#035A8F", "#035A8F"],
          begin: Alignment.bottomRight, 
          end: Alignment.topLeft, 
          action: (){
            Navigator.push(
              context, 
              Transition(child: ReceiveWallet(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT)
            );
          }
        )
      ],
    );
  }

  Widget categoryToken(){

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: model!.categories!.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            CategoryCard(
              index: index,
              title: model!.categories![index],
              selectedIndex: model!.categoryIndex!,
              onTap: onTapCategories!,
            ),

            SizedBox(width: 2.5.w),
          ],
        );
      }
    );
  }
}