import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/dialog_c.dart';
import 'package:wallet_apps/src/components/document_card_c.dart';
import 'package:wallet_apps/src/models/digital_id_m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/assets/assets.dart';
import 'package:wallet_apps/src/screen/home/create_document/create_document.dart';
import 'package:wallet_apps/src/screen/home/documents/setup_kyc.dart';

class HomeBody extends StatelessWidget {

  final HomePageModel? homePageModel;
  final bool? pushReplacement;
  final CTypeModel? cTypeModel;
  final Function(int index)? onPageChanged;
  // final Function? queryCType;
  final TabController? tabBarController;
  final Color? selectedColor;
  final Function? scanLogin;
  final Function? getPendingDocs;
  final Function? deleteAccount;
  final Function? bindAcc;

  const HomeBody({ 
    Key? key, 
    this.homePageModel,
    this.onPageChanged,
    this.pushReplacement,
    this.cTypeModel,
    // this.queryCType,
    this.tabBarController,
    this.selectedColor,
    this.scanLogin,
    this.getPendingDocs,
    this.deleteAccount,
    this.bindAcc
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
            await bindAcc!();
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
      
                        RefreshIndicator(
                          onRefresh: () async {
                            await Provider.of<DocumentProvider>(context, listen: false).queryAssetOf();
                          },
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: provider.docsModel.pending.isNotEmpty ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.docsModel.pending.length,
                              itemBuilder: (context, index){
                                return CardDocument(data: provider.docsModel.pending[index], isDetail: false,);
                              }
                            )
                            : 
                            Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(AppConfig.logoPath+"document.png", width: 178, height: 178),
                                    MyText(text: "No Documents", fontSize: 18,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: provider.assetsMinted!.length,
                        //   itemBuilder: (context, index){
                        //     return CardDocument(data: provider.assetsMinted![index], isDetail: false,);
                        //   }
                        // ),
      
                        RefreshIndicator(
                          onRefresh: () async {
                            await Provider.of<DocumentProvider>(context, listen: false).queryAssetOf();
                          },
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Container(
                              child: provider.docsModel.approve.isNotEmpty ?  ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.docsModel.approve.length,
                              itemBuilder: (context, index){
                                return CardDocument(data: provider.docsModel.approve[index], isDetail: false,);
                              }
                            )
                            : 
                            Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(AppConfig.logoPath+"document.png", width: 178, height: 178),
                                    MyText(text: "No Documents", fontSize: 18,)
                                  ],
                                ),
                              ),
                            ),
                            ),
                          ),
                        )
                        
                        
                      ],
                    )
                  ),
                ],
              ) 
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
      
                  // GestureDetector(
                  //   child: MyText(
                  //     text: "Connect Handler",
                  //   ),
                  //   onTap: () async {
                  //     await deleteAccount!();
                  //     // await Provider.of<ApiProvider>(context, listen: false).connectToHandler();
                  //   },
                  // ),
      
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 50,
                  //   child: GestureDetector(
                  //     child: MyText(
                  //       text: "queryListOfOrgs",
                  //     ),
                  //     onTap: () async {
                  //       // queryAssetOf!();
                  //       await Provider.of<DocumentProvider>(context, listen: false).queryAllOrgs();
                  //     },
                  //   ),
                  // ),
      
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
                      action: () async {
                        print("Setup Selendra IDprovider.object ${provider.object}");
                        if (provider.object != null){
                          provider.title = provider.lsDocs![2].lsOrg![0].details!['name'];

                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => CreateDocument(ownerId: provider.lsDocs![2].lsOrg![0].owner))
                          );
                        } else {
                          await provider.queryAllOrgs();
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpKYC(isSelendraID: true,)));
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
      floatingActionButton: Consumer<DocumentProvider>(
        builder: (context, provider, widget){
          
          // homePageModel!.pageController!.page.toString() == "1.0"
          return (provider.docsModel.pending.isNotEmpty || provider.docsModel.approve.isNotEmpty) ? FloatingActionButton(
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