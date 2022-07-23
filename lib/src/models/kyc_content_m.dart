import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/kyc/issuer.dart';
class KYCDocs {

  static BuildContext? context;

  static List<CustomButtonIcon>? lsPopularDocs = [];

  static List<CustomButtonIcon>? lsIssuer = [];

  List<Map<String, dynamic>> data = [];

  KYCDocs(){

    // data = [
    //   {
    //     "type": "National ID",
    //     "id": "1233452423",
    //     "name": "Sam Allen",
    //     "dob": "09.02.2000",
    //     "address": "Tik L'lork, Toul Kork, Phnom Penh",
    //     "status": "verifying",
    //     "isVeried": false,
    //   },
    //   {
    //     "type": "Driver licence",
    //     "id": "1233452423",
    //     "name": "Sam Allen",
    //     "dob": "09.02.2000",
    //     "address": "Tik L'lork, Toul Kork, Phnom Penh",
    //     "status": "verifying",
    //     "isVeried": false,
    //   },
    //   {
    //     "type": "Covid Vaccination",
    //     "id": "1233452423",
    //     "name": "Sam Allen",
    //     "dob": "09.02.2000",
    //     "address": "Tik L'lork, Toul Kork, Phnom Penh",
    //     "status": "verified",
    //     "isVeried": true,
    //   }
    // ];
  }

  static void initContext({required BuildContext? context}){
    context = context;

    DocumentProvider provider = Provider.of<DocumentProvider>(context!, listen: false);
  
    lsPopularDocs =  [
      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'National ID';
          MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'National ID',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'Passport';
          MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'Passport',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'Vehicle License';
          Navigator.push(
            context!, 
            Transition(
              child: IssuerListForm(
                createID: (){
                  MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
                },
              ),
              transitionEffect: TransitionEffect.RIGHT_TO_LEFT
            )
          );
        },
        text: 'Vehicle License',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'Driver License';
          Navigator.push(
            context!, 
            Transition(
              child: IssuerListForm(
                createID: (){
                  MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
                },
              ),
              transitionEffect: TransitionEffect.RIGHT_TO_LEFT
            )
          );
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
          Navigator.push(
            context!, 
            Transition(
              child: IssuerListForm(
                createID: (){
                  MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
                },
              ),
              transitionEffect: TransitionEffect.RIGHT_TO_LEFT
            )
          );
        },
        text: 'MPTC',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'MoEYs';
          Navigator.push(
            context!, 
            Transition(
              child: IssuerListForm(
                createID: (){
                  MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
                },
              ),
              transitionEffect: TransitionEffect.RIGHT_TO_LEFT
            )
          );
        },
        text: 'MoEYs',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

      CustomButtonIcon(
        onPressed: () async {
          provider.title = 'CSX';
          Navigator.push(
            context!, 
            Transition(
              child: IssuerListForm(
                createID: (){
                  MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
                },
              ),
              transitionEffect: TransitionEffect.RIGHT_TO_LEFT
            )
          );
        },
        text: 'CSX',
        icon: const Icon(Iconsax.arrow_right_3),
        colorBtn: Colors.white.withOpacity(0.06),
        colorText: Colors.white,
      ),

    ];

  }
}