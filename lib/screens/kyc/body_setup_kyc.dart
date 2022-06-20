import 'package:digital_id/all_export.dart';
import 'package:digital_id/screens/digital_id/front_side/front_side.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class SetUpKYCBody extends StatelessWidget {
  final GlobalKey<ExpansionTileCardState> popularDocs = GlobalKey();
  final GlobalKey<ExpansionTileCardState> issuer = GlobalKey();

  SetUpKYCBody({
    Key? key, 
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
              padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(8.0),
              child: MyText(
                text: 'Popular document',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
      
            _popularDocs(context, popularDocs),
      
            SizedBox(height: paddingSize),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyText(
                text: 'Issuer',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
      
            _issuer(context, issuer),
          ],
        ),
      ),
    );
  }

  Widget _mandatory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomButtonIcon(
        onPressed: () async => {
          createIDBottomSheet(context),
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const FrontSide())),
        },
        text: 'National ID',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),
    );
  }

  Widget _popularDocs(BuildContext context, GlobalKey<ExpansionTileCardState> key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTileCard(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            baseColor: whiteColor.withOpacity(0.06),
            expandedColor: whiteColor.withOpacity(0.06),
            elevation: 0,
            key: key,
            title: MyText(
              text: 'Popular Documents', 
              fontWeight: FontWeight.bold, 
              color: AppColors.whiteColor
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButtonIcon(
                  onPressed: () async => {
                    createIDBottomSheet(context),
                  },
                  text: 'National ID',
                  icon: const Icon(Iconsax.arrow_right_3),
                  colorBtn: whiteColor.withOpacity(0.06),
                  colorText: whiteColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButtonIcon(
                  onPressed: () async => {
                    createIDBottomSheet(context),
                  },
                  text: 'Vehicle license',
                  icon: const Icon(Iconsax.arrow_right_3),
                  colorBtn: whiteColor.withOpacity(0.06),
                  colorText: whiteColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButtonIcon(
                  onPressed: () async => {
                    createIDBottomSheet(context),
                  },
                  text: 'Driver License',
                  icon: const Icon(Iconsax.arrow_right_3),
                  colorBtn: whiteColor.withOpacity(0.06),
                  colorText: whiteColor,
                ),
              ),
            ],
          )
        )
      ],
    );
  }

  Widget _issuer(BuildContext context, GlobalKey<ExpansionTileCardState> key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTileCard(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            baseColor: whiteColor.withOpacity(0.06),
            expandedColor: whiteColor.withOpacity(0.06),
            elevation: 0,
            key: key,
            title: MyText(
              text: 'Issuer', 
              fontWeight: FontWeight.bold, 
              color: AppColors.whiteColor
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButtonIcon(
                  onPressed: () async => {
                    createIDBottomSheet(context),
                  },
                  text: 'MPTC',
                  icon: const Icon(Iconsax.arrow_right_3),
                  colorBtn: whiteColor.withOpacity(0.06),
                  colorText: whiteColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButtonIcon(
                  onPressed: () async => {
                    createIDBottomSheet(context),
                  },
                  text: 'MoEYs',
                  icon: const Icon(Iconsax.arrow_right_3),
                  colorBtn: whiteColor.withOpacity(0.06),
                  colorText: whiteColor,
                ),
              ),
            ],
          )
        )
      ],
    );
  }

}