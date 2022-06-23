import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
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
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'Passport';
          createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'Passport',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'Vehicle License';
          createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'Vehicle License',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'Driver License';
          createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'Driver License',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
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
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'MoEYs';
          createIDBottomSheet(context!, provider.lsIssuerProp!);
        },
        text: 'MoEYs',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'CSX';
          createIDBottomSheet(context!, provider.lsIssuerProp!);
        },
        text: 'CSX',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

    ];

  }
}