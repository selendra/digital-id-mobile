import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wallet_apps/index.dart';
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

  DocumentProvider(){
    kycDocs.data = [];
    // kycDocs.data = [
    //   {
    //     "type": "National ID",
    //     "id": "1233452423",
    //     "name": "Sam Allen",
    //     "dob": "09.02.2000",
    //     "gender": "Female",
    //     "address": "Tik L'lork, Toul Kork, Phnom Penh",
    //     "status": "verifying",
    //     "isVeried": false,
    //     "color": "#D5ECC2",
    //     "height": "165",
    //     "identity": "Scar on the left side 1cm",
    //     "isApprove": false
    //   },
    //   {
    //     "type": "Driver licence",
    //     "id": "1233452423",
    //     "name": "Sam Allen",
    //     "dob": "09.02.2000",
    //     "gender": "Male",
    //     "address": "Tik L'lork, Toul Kork, Phnom Penh",
    //     "status": "verifying",
    //     "isVeried": false,
    //     "color": "#98DDCA",
    //     "height": "175",
    //     "identity": "Scar on the left side 1cm",
    //     "isApprove": true
    //   },
    //   {
    //     "type": "Covid Vaccination",
    //     "id": "1233452423",
    //     "name": "Sam Allen",
    //     "dob": "09.02.2000",
    //     "gender": "Male",
    //     "address": "Tik L'lork, Toul Kork, Phnom Penh",
    //     "status": "verified",
    //     "isVeried": true,
    //     "color": "#FFAAA7",
    //     "height": "188",
    //     "identity": "Scar on the left side 1cm",
    //     "isApprove": false
    //   }
    // ];

    // docsFilter();

  }

  /// Status Filter
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
    
    print("kycDocs.pending ${kycDocs.pending}");
    print("kycDocs.approve ${kycDocs.approve}");

    // notifyListeners();
  }
  
  Future<void> initJson() async {
    lsMandotaryProp = [];
    final jsonData = await rootBundle.loadString(AppConfig.mandatory);
    print("jsonData jsonData ${jsonData}");
    mandotary = json.decode(jsonData);
    popular = json.decode(jsonData);
    popular!['properties'].addAll({
      'city': {'type': 'string', 'description': "Battambang"}
    });

    print("popular $popular");
    issuer = json.decode(jsonData);
    issuer!['properties'].addAll({
      'gender': {'type': 'string', 'description': "Male"},
      'city': {'type': 'string', 'description': "Phnom Penh"},
    });
    print("issuer $issuer");

    Map<String, dynamic>.from(mandotary!['properties']).forEach((key, value) {
      print("Value $value");
      lsMandotaryProp!.add({
        'key': key,
        'value': value,
        'formController': TextEditingController(),
        'focusNode': FocusNode(),
        'type': value['type']
      });
    });
    
    Map<String, dynamic>.from(popular!['properties']).forEach((key, value) {
      lsPopularProp!.add({
        'key': key,
        'value': value,
        'formController': TextEditingController(),
        'focusNode': FocusNode(),
        'type': value['type']
      });
    });

    Map<String, dynamic>.from(issuer!['properties']).forEach((key, value) {
      lsIssuerProp!.add({
        'key': key,
        'value': value,
        'formController': TextEditingController(),
        'focusNode': FocusNode(),
        'type': value['type']
      });
    });

    final myJson = await rootBundle.loadString(AppConfig.selendra_id);
    selendra = json.decode(myJson);
    print("Init selendra ${selendra!['properties']}");
    Map<String, dynamic>.from(selendra!['properties']).forEach((key, value) {
      print("value['editable'] ${value['editable']}");
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
}