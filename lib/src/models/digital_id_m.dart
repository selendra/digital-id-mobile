import 'package:wallet_apps/index.dart';
import 'package:web3dart/web3dart.dart';

class DigitalIDModel {

  String? title = '';
  String? frontImage = '';
  String? backImage = '';
  String? selfieImage = '';
  String? backFaceImage = '';
  List<String>? lsIDCard = [];
  bool? completedSetpUpID = false;

  DigitalIDModel fromDb(Map<String, dynamic> json){
    title = json['title'] ?? title;
    frontImage = json['front'] ?? frontImage;
    backImage = json['back'] ?? backImage;
    selfieImage = json['front_face'] ?? selfieImage;
    backFaceImage = json['back_face'] ?? backFaceImage;
    completedSetpUpID = json['completed'] ?? completedSetpUpID;

    lsIDCard = [
      frontImage!,
      backImage!,
      selfieImage!,
    ];
    return this; 
  }

  Map<String, dynamic> toJson(DigitalIDModel model){
    return {
      'title': model.title,
      'front': model.frontImage,
      'back': model.backImage,
      'front_face': model.selfieImage,
      'back_face': model.backFaceImage,
      'ls_ids': model.lsIDCard,
      'completed': model.completedSetpUpID
    };
  }
  
}

class CTypeModel {
  
  BigInt? orgId;
  BigInt? CTypeId;
  EthereumAddress? issuer;
  String? propertiesURI;
  String? propertiesHash;
  bool? transferable;
  bool? revokable;
  bool? expirable;
  BigInt? lifespan;
  BigInt? status;

  List<Map<String, dynamic>>? cTypeProperties;

  fromQuery(List<dynamic> ls){
    orgId = ls[0]; 
    CTypeId = ls[1];
    issuer = ls[2];
    propertiesURI = ls[3];
    propertiesHash = ls[4];
    transferable = ls[5];
    revokable = ls[6];
    expirable = ls[7];
    lifespan = ls[8];
    status = ls[9];

    return this;
  }

  cTypePropertiesFilter(Map<String, dynamic> ls){
    print("cTypePropertiesFilter ls['properties'] ${ls['properties']['name']}");
    List<dynamic> tmp = ls['properties'].toString().split(", ");

    tmp.forEach((element) {
      print("element ${element}");
      // cTypeProperties!.add(
      //   element
      // );
    });
  }
}