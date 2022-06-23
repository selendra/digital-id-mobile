import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wallet_apps/index.dart';

class DocumentProvider extends ChangeNotifier{

  String? title;

  Map<String, dynamic>? mandotary;
  Map<String, dynamic>? popular;
  Map<String, dynamic>? issuer;

  // List Properties
  List<dynamic>? lsMandotaryProp = [];
  List<dynamic>? lsPopularProp = [];
  List<dynamic>? lsIssuerProp = [];
  
  // Future<void> initJson() async {
  //   lsMandotaryProp = [];
  //   final jsonData = await rootBundle.loadString(AppConfig.mandatory);
  //   mandotary = json.decode(jsonData);
  //   popular = json.decode(jsonData);
  //   popular!['properties'].addAll({
  //     'city': {'type': 'string', 'description': "Battambang"}
  //   });

  //   print("popular $popular");
  //   issuer = json.decode(jsonData);
  //   issuer!['properties'].addAll({
  //     'gender': {'type': 'string', 'description': "Male"},
  //     'city': {'type': 'string', 'description': "Phnom Penh"},
  //   });
  //   print("issuer $issuer");

  //   Map<String, dynamic>.from(mandotary!['properties']).forEach((key, value) {
  //     print("Value $value");
  //     lsMandotaryProp!.add({
  //       'key': key,
  //       'value': value,
  //       'formController': TextEditingController(),
  //       'focusNode': FocusNode(),
  //       'type': value['type']
  //     });
  //   });
    
  //   Map<String, dynamic>.from(popular!['properties']).forEach((key, value) {
  //     lsPopularProp!.add({
  //       'key': key,
  //       'value': value,
  //       'formController': TextEditingController(),
  //       'focusNode': FocusNode(),
  //       'type': value['type']
  //     });
  //   });

  //   Map<String, dynamic>.from(issuer!['properties']).forEach((key, value) {
  //     lsIssuerProp!.add({
  //       'key': key,
  //       'value': value,
  //       'formController': TextEditingController(),
  //       'focusNode': FocusNode(),
  //       'type': value['type']
  //     });
  //   });
  // }
}