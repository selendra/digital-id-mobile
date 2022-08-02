import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';
import 'package:wallet_apps/src/models/document_schema.dart';
import 'package:wallet_apps/src/models/kyc_content_m.dart';

class DocumentProvider extends ChangeNotifier{

  String? title;

  Map<String, dynamic>? mandotary;
  Map<String, dynamic>? selendra;
  Map<String, dynamic>? popular;
  Map<String, dynamic>? issuer;

  // List Properties
  List<dynamic>? selendraID = [];
  List<dynamic>? lsMandotaryProp = [];
  List<dynamic>? lsPopularProp = [];
  List<dynamic>? lsIssuerProp = [];

  KYCDocs kycDocs = KYCDocs();

  List<DocumentSchema>? lsDocs;

  DocumentProvider(){
    kycDocs.data = [];
    kycDocs.data = [
      {
        "type": "National ID",
        "id": "1233452423",
        "name": "Sam Allen",
        "dob": "09.02.2000",
        "gender": "Female",
        "address": "Tik L'lork, Toul Kork, Phnom Penh",
        "status": "verifying",
        "isVeried": false,
        "color": "#D5ECC2",
        "height": "165",
        "identity": "Scar on the left side 1cm",
        "expired_date": "2022.01.21 - 2025.01.21",
        "isApprove": false
      },
      {
        "type": "Driver licence",
        "id": "1233452423",
        "name": "Sam Allen",
        "dob": "09.02.2000",
        "gender": "Male",
        "address": "Tik L'lork, Toul Kork, Phnom Penh",
        "status": "verifying",
        "isVeried": false,
        "color": "#98DDCA",
        "height": "175",
        "identity": "Scar on the left side 1cm",
        "expired_date": "2022.01.21 - 2025.01.21",
        "isApprove": true
      },
      {
        "type": "Covid Vaccination",
        "id": "1233452423",
        "name": "Sam Allen",
        "dob": "09.02.2000",
        "gender": "Male",
        "address": "Tik L'lork, Toul Kork, Phnom Penh",
        "status": "verified",
        "isVeried": true,
        "color": "#FFAAA7",
        "height": "188",
        "identity": "Scar on the left side 1cm",
        "expired_date": "2022.01.21 - 2025.01.21",
        "isApprove": false
      }
    ];

    docsFilter();

  }


  void initContext({required BuildContext? context}) async {
    
    context = context;

    // DocumentProvider provider = Provider.of<DocumentProvider>(context!, listen: false);
    // print("_docJson");
    // lsPopularDocs =  [
    //   CustomButtonCard(
    //     onPressed: () async {
    //       provider.title = 'National ID';
    //       MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
    //     },
    //     text: 'National ID',
    //     image: SvgPicture.asset("assets/logo/national-id.svg"),
    //   ),

    //   CustomButtonCard(
    //     onPressed: () async {
    //       provider.title = 'Passport';
    //       MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
    //     },
    //     text: 'Passport',
    //     image: SvgPicture.asset("assets/logo/passport.svg"),
    //   ),

    //   CustomButtonCard(
    //     onPressed: () async {
    //       provider.title = 'Land Title';
    //       MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
    //     },
    //     text: 'Land Title',
    //     image: SvgPicture.asset("assets/logo/land-title.svg"),
    //   ),

    //   CustomButtonCard(
    //     onPressed: () async {
    //       provider.title = 'Vehicle License';
    //       Navigator.push(
    //         context!, 
    //         Transition(
    //           child: IssuerListForm(
    //             createID: (){
    //               MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
    //             },
    //           ),
    //           transitionEffect: TransitionEffect.RIGHT_TO_LEFT
    //         )
    //       );
    //     },
    //     text: 'Vehicle License',
    //     image: SvgPicture.asset("assets/logo/vehicle-license.svg"),
    //   ),

    //   CustomButtonCard(
    //     onPressed: () async {
    //       provider.title = 'Driver License';
    //       Navigator.push(
    //         context!, 
    //         Transition(
    //           child: IssuerListForm(
    //             createID: (){
    //               MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
    //             },
    //           ),
    //           transitionEffect: TransitionEffect.RIGHT_TO_LEFT
    //         )
    //       );
    //     },
    //     text: 'Driver License',
    //     image: SvgPicture.asset("assets/logo/driver-license.svg"),
    //   ),
    // ];

    // lsIssuer =  [
    
    //   CustomButtonCard(
    //     onPressed: () async {
    //       provider.title = 'MPTC';
    //       Navigator.push(
    //         context!, 
    //         Transition(
    //           child: IssuerListForm(
    //             createID: (){
    //               MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
    //             },
    //           ),
    //           transitionEffect: TransitionEffect.RIGHT_TO_LEFT
    //         )
    //       );
    //     },
    //     text: 'MPTC',
    //     image: Image.network("https://asset.cambodia.gov.kh/mptc/media/2020/05/cropped-PTC-HD-LOGO-512px-6.png"),
    //   ),

    //   CustomButtonCard(
    //     onPressed: () async {
    //       provider.title = 'MoEYs';
    //       Navigator.push(
    //         context!, 
    //         Transition(
    //           child: IssuerListForm(
    //             createID: (){
    //               MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
    //             },
    //           ),
    //           transitionEffect: TransitionEffect.RIGHT_TO_LEFT
    //         )
    //       );
    //     },
    //     text: 'MoEYs',
    //     image: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/MoEYS_%28Cambodia%29.svg/444px-MoEYS_%28Cambodia%29.svg.png?20110624073833")
    //   ),

    //   CustomButtonCard(
    //     onPressed: () async {
    //       provider.title = 'MPWT';
    //       Navigator.push(
    //         context!, 
    //         Transition(
    //           child: IssuerListForm(
    //             createID: (){
    //               MyBottomSheet().createIDBottomSheet(context!, provider.lsPopularProp!);
    //             },
    //           ),
    //           transitionEffect: TransitionEffect.RIGHT_TO_LEFT
    //         )
    //       );
    //     },
    //     text: 'MPWT',
    //     image: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Ministry_of_Public_Works_and_Transport_%28Cambodia%29_Logo.jpg/640px-Ministry_of_Public_Works_and_Transport_%28Cambodia%29_Logo.jpg")
    //   ),

    // ];

  }

  /// Data Document Status Filter
  void docsFilter(){
    kycDocs.pending = [];
    kycDocs.approve = [];
    kycDocs.data.forEach((element) {
      if (element['isApprove'] == false) {
        kycDocs.pending.add(element);
      } else {
        kycDocs.approve.add(element);
      }
    });
    
    kycDocs.selendra.add({
      "type": "Selendar ID",
      "id": "1233452423",
      "name": "Sam Allen",
      "dob": "09.02.2000",
      "gender": "Male",
      "address": "Tik L'lork, Toul Kork, Phnom Penh",
      "status": "verified",
      "isVeried": true,
      "color": "#FFAAA7",
      "height": "188",
      "identity": "Scar on the left side 1cm",
      "expired_date": "2022.01.21 - 2025.01.21",
      "isApprove": false
    });

    // notifyListeners();
  }
  
  /// Init and filter property of document
  /// 
  /// Run Second
  Future<void> initJson() async {

    lsMandotaryProp = [];
    lsPopularProp = [];
    lsIssuerProp = [];

    popular = {};
    issuer = {};

    final jsonData = await rootBundle.loadString(AppConfig.mandatory);
    mandotary = json.decode(jsonData);
    
    popular = json.decode(jsonData);
    popular!['properties'].addAll({
      'city': {'type': 'string', 'description': "Battambang"}
    });

    issuer = json.decode(jsonData);
    issuer!['properties'].addAll({
      'gender': {'type': 'string', 'description': "Male"},
      'city': {'type': 'string', 'description': "Phnom Penh"},
    });

    Map<String, dynamic>.from(mandotary!['properties']).forEach((key, value) {
      lsMandotaryProp!.add({
        'key': key,
        'value': value,
        'formController': TextEditingController(),
        'focusNode': FocusNode(),
        'type': value['type']
      });
    });

    lsDocs![0].docsProperty = lsMandotaryProp!;
    
    Map<String, dynamic>.from(popular!['properties']).forEach((key, value) {
      lsPopularProp!.add({
        'key': key,
        'value': value,
        'formController': TextEditingController(),
        'focusNode': FocusNode(),
        'type': value['type']
      });
    });

    lsDocs![1].docsProperty = lsPopularProp!;

    Map<String, dynamic>.from(issuer!['properties']).forEach((key, value) {
      lsIssuerProp!.add({
        'key': key,
        'value': value,
        'formController': TextEditingController(),
        'focusNode': FocusNode(),
        'type': value['type']
      });
    });

    lsDocs![2].docsProperty = lsIssuerProp!;
    print("lsDocs![2].docsList ${lsDocs![2].docsList}");

    notifyListeners();
  }

  Future<void> initSelendraDocs() async {

    
    final myJson = await rootBundle.loadString(AppConfig.selendra_id);
    selendra = json.decode(myJson);
    Map<String, dynamic>.from(selendra!['properties']).forEach((key, value) {
      selendraID!.add({
        'key': key,
        'value': value,
        'formController': TextEditingController(),
        'focusNode': FocusNode(),
        'type': value['type'],
        'editable': value['editable'],
        'description': value['description']
      });
    });

    notifyListeners();
  }

  /// Run First;
  void initDocs() async {
    print("initDocs");
    lsDocs = [];
    await rootBundle.loadString(AppConfig.docJson).then((value) {
      // _docJson = 
      // print(json.decode(value)['docs']);
      json.decode(value)['docs'].forEach((element) {
        print(element);
        // kycDocs.data.add(element);
        lsDocs!.add(
          DocumentSchema(
            type: element['type'],
            docsList: element['docs_list']
            // .forEach((data){
            //   DocumentProperty(
            //     title: data['title'],
            //     image: data['image'],
            //     color: data['color'],
            //   );
            // }).toList(),
          )
        );
      });

      print("lsDocs $lsDocs");
      initJson();
    });
    
  }
}