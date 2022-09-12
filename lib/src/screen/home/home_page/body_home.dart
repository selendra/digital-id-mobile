import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/dialog_c.dart';
import 'package:wallet_apps/src/components/document_card_c.dart';
import 'package:wallet_apps/src/models/digital_id_m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/assets/assets.dart';
import 'package:wallet_apps/src/screen/home/documents/setup_kyc.dart';

class HomeBody extends StatelessWidget {

  final HomePageModel? homePageModel;
  final bool? pushReplacement;
  final CTypeModel? cTypeModel;
  final Function(int index)? onPageChanged;
  final Function? queryCType;
  final TabController? tabBarController;
  final Color? selectedColor;
  final Function? scanLogin;
  final Function? getPendingDocs;
  final Function? deleteAccount;
  final Function? queryAssetOf;

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
    this.getPendingDocs,
    this.deleteAccount,
    this.queryAssetOf,
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
          onPressed: () async   {
            queryAssetOf!();
            // await deleteAccount!();
            // homePageModel!.globalKey!.currentState!.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              // Iconsax.scan_barcode,
              homePageModel!.activeIndex == 2 ? Iconsax.scan_barcode : Iconsax.scan,
              color: hexaCodeToColor(AppColors.secondary),
            ),
            onPressed: () async {

              if (homePageModel!.pageController!.page == 2 ){

                await DialogComponents().dialogQR(context: context, keyQrShare: GlobalKey(), data: {"type": "Selendra ID"});
              } else {

                await TrxOptionMethod().scanQR(
                  context,
                  [],
                  pushReplacement!,
                ).then((value) async {
                  if (value != null){
                    await scanLogin!(value);
                  }
                });
              }
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
        
              return provider.assetsMinted!.isNotEmpty ? Column(
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
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
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

                        provider.docsModel.pending.isNotEmpty ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.docsModel.pending.length,
                          itemBuilder: (context, index){
                            return CardDocument(data: provider.docsModel.pending[index], isDetail: false,);
                          }
                        ) : Center(child: Image.asset(AppConfig.logoPath+"document.png", width: 178, height: 178)),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: provider.assetsMinted!.length,
                        //   itemBuilder: (context, index){
                        //     return CardDocument(data: provider.assetsMinted![index], isDetail: false,);
                        //   }
                        // ),

                        provider.docsModel.approve.isNotEmpty ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.docsModel.approve.length,
                          itemBuilder: (context, index){
                            return CardDocument(data: provider.docsModel.approve[index], isDetail: false,);
                          }
                        ) : Center(child: Image.asset(AppConfig.logoPath+"document.png", width: 178, height: 178)),
                        
                      ],
                    )
                  ),
                ],
              ) 
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  GestureDetector(
                    child: MyText(
                      text: "Connect Handler",
                    ),
                    onTap: () async {
                      await deleteAccount!();
                      // await Provider.of<ApiProvider>(context, listen: false).connectToHandler();
                    },
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: GestureDetector(
                      child: MyText(
                        text: "queryListOfOrgs",
                      ),
                      onTap: () async {
                        // queryAssetOf!();
                        await Provider.of<DocumentProvider>(context, listen: false).queryAllOrgs();
                      },
                    ),
                  ),

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
                      // MyBottomSheet().createIDBottomSheet(context, Provider.of<DocumentProvider>(context, listen: false).selendraID!);
                      // Provider.of<DocumentProvider>(context, listen: false).title = "Selendra ID";
                      // Navigator.push(
                      //   context, 
                      //   MaterialPageRoute(builder: (context) => CreateDocument(docs: Provider.of<DocumentProvider>(context, listen: false).selendraID!))
                      // );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpKYC()));
                    },
                  ),
                ],
              );
            }
          ),
      
          Account()
        ],
      ),

      floatingActionButton: 
      //  
      Consumer<DocumentProvider>(
        builder: (context, provider, widget){
          
          return homePageModel!.pageController!.page.toString() == "1.0" ? FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpKYC()));
            },
            child: Icon(Iconsax.add_circle, color: Colors.white, size: 9.w,),
            backgroundColor: hexaCodeToColor(AppColors.newPrimary),
          ) : Container();
        }
      )
      //  : Container(),
    );
  }

}