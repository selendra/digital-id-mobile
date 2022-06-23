import 'package:digital_id/all_export.dart';
import 'package:digital_id/provider/documents_p.dart';
import 'package:provider/provider.dart';

class KYCDocs {

  static BuildContext? context;

  static List<CustomButtonIcon>? lsPopularDocs = [];

  static List<CustomButtonIcon>? lsIssuer = [];

  static void initContext({required BuildContext? context}){
    context = context;

    DocumentProvider provider = Provider.of<DocumentProvider>(context!, listen: false);
  
    lsPopularDocs =  [
      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'National ID';
          createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'National ID',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'Passport';
          createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'Passport',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'Vehicle License';
          createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'Vehicle License',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'Driver License';
          createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'Driver License',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),
    ];

    lsIssuer =  [
      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'MPTC';
          createIDBottomSheet(context!, provider.lsIssuerProp!);
        },
        text: 'MPTC',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'MoEYs';
          createIDBottomSheet(context!, provider.lsIssuerProp!);
        },
        text: 'MoEYs',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'CSX';
          createIDBottomSheet(context!, provider.lsIssuerProp!);
        },
        text: 'CSX',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

    ];

  }
}