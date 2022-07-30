import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/kyc/issuer.dart';
class KYCDocs {

  static BuildContext? context;

  static List<CustomButtonCard>? lsPopularDocs = [];

  static List<CustomButtonCard>? lsIssuer = [];

  List<Map<String, dynamic>> data = [];

  List<Map<String, dynamic>> selendra = [];
  List<Map<String, dynamic>> pending = [];
  List<Map<String, dynamic>> approve = [];

  static void initContext({required BuildContext? context}){
    context = context;

    DocumentProvider provider = Provider.of<DocumentProvider>(context!, listen: false);
  
    lsPopularDocs =  [
      CustomButtonCard(
        onPressed: () async {
          provider.title = 'National ID';
          MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'National ID',
        image: SvgPicture.asset("assets/logo/national-id.svg"),
      ),

      CustomButtonCard(
        onPressed: () async {
          provider.title = 'Passport';
          MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'Passport',
        image: SvgPicture.asset("assets/logo/passport.svg"),
      ),

      CustomButtonCard(
        onPressed: () async {
          provider.title = 'Land Title';
          MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
        },
        text: 'Land Title',
        image: SvgPicture.asset("assets/logo/land-title.svg"),
      ),

      CustomButtonCard(
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
        image: SvgPicture.asset("assets/logo/vehicle-license.svg"),
      ),

      CustomButtonCard(
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
        image: SvgPicture.asset("assets/logo/driver-license.svg"),
      ),
    ];

    lsIssuer =  [
    
      CustomButtonCard(
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
        image: Image.network("https://asset.cambodia.gov.kh/mptc/media/2020/05/cropped-PTC-HD-LOGO-512px-6.png"),
      ),

      CustomButtonCard(
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
        image: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/MoEYS_%28Cambodia%29.svg/444px-MoEYS_%28Cambodia%29.svg.png?20110624073833")
      ),

      CustomButtonCard(
        onPressed: () async {
          provider.title = 'MPWT';
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
        text: 'MPWT',
        image: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Ministry_of_Public_Works_and_Transport_%28Cambodia%29_Logo.jpg/640px-Ministry_of_Public_Works_and_Transport_%28Cambodia%29_Logo.jpg")
      ),

    ];

  }
}