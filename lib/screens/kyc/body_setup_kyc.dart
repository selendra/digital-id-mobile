import 'package:digital_id/all_export.dart';
import 'package:digital_id/models/kyc_content_m.dart';
import 'package:digital_id/screens/digital_id/front_side/front_side.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class SetUpKYCBody extends StatelessWidget {

  final bool? isShowMorePopularDocs;
  final bool? isShowMoreIssuer;
  final Function? onShowMorePopularDocs;
  final Function? onShowMoreIssuer;

  const SetUpKYCBody({
    Key? key, 
    this.isShowMorePopularDocs,
    this.isShowMoreIssuer,
    this.onShowMorePopularDocs,
    this.onShowMoreIssuer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSize,),
              child: MyText(
                text: 'Mandatory',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
      
            _mandatory(context),
            
            SizedBox(height: paddingSize),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSize),
              child: MyText(
                text: 'Popular document',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
      
            _popularDocs(context, isShowMorePopularDocs!), //!),
      
            SizedBox(height: paddingSize),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSize),
              child: MyText(
                text: 'Issuer',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
      
            _issuer(context, isShowMoreIssuer!),
          ],
        ),
      ),
    );
  }

  Widget _mandatory(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: CustomButtonIcon(
        onPressed: () async => {
          createIDBottomSheet(context),
        },
        text: 'National ID',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),
    );
  }

  Widget _popularDocs(BuildContext context, bool _isShowMorePopularDocs) {
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: Column(
        children: [
          AnimatedSize(
            curve: _isShowMorePopularDocs == true ? Curves.easeIn : Curves.easeOut,
            duration: const Duration(milliseconds: 300),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _isShowMorePopularDocs == false ? 3 : KYCDocs.lsPopularDocs!.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KYCDocs.lsPopularDocs![index],
                    ],
                  ),
                );
              }
            ),
          ),

          CustomButton(
            colorBtn: whiteColor.withOpacity(0.06),
            text: _isShowMorePopularDocs == false ? "Show More" : "Show Less",
            onPressed: () {
              onShowMorePopularDocs!();
            }
          ),
        ],
      ),
    );
  }

  Widget _issuer(BuildContext context, bool _isShowMoreIssuer) {
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: Column(
        children: [
          AnimatedSize(
            curve: _isShowMoreIssuer == true ? Curves.easeIn : Curves.easeOut,
            duration: const Duration(milliseconds: 300),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _isShowMoreIssuer == false ? 2 : KYCDocs.lsIssuer!.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KYCDocs.lsIssuer![index],
                    ],
                  ),
                );
              }
            ),
          ),

          CustomButton(
            colorBtn: whiteColor.withOpacity(0.06),
            text: _isShowMoreIssuer == false ? "Show More" : "Show Less",
            onPressed: () {
              onShowMoreIssuer!();
            }
          ),
        ],
      ),
    );
  }

}