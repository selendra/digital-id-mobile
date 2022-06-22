import 'package:digital_id/all_export.dart';

class KYCDocs {

  static BuildContext? context;

  static List<CustomButtonIcon>? lsPopularDocs = [];

  static List<CustomButtonIcon>? lsIssuer = [];

  static void initContext({required BuildContext? context}){
    context = context;
  
    lsPopularDocs =  [
      CustomButtonIcon(
        onPressed: () async => {
          createIDBottomSheet(context!),
        },
        text: 'National ID',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async => {
          createIDBottomSheet(context!),
        },
        text: 'Passport',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async => {
          createIDBottomSheet(context!),
        },
        text: 'Vehicle License',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async => {
          createIDBottomSheet(context!),
        },
        text: 'Driver License',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),
    ];

    lsIssuer =  [
      CustomButtonIcon(
        onPressed: () async => {
          createIDBottomSheet(context!),
        },
        text: 'MPTC',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async => {
          createIDBottomSheet(context!),
        },
        text: 'MoEYs',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

      CustomButtonIcon(
        onPressed: () async => {
          createIDBottomSheet(context!),
        },
        text: 'CSX',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: whiteColor.withOpacity(0.06),
        colorText: whiteColor,
      ),

    ];

  }
}