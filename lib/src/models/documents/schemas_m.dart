import 'package:wallet_apps/src/models/documents/org_m.dart';

class SchemasModel extends OrgModel {

  // Detail Properties
  OrgModel? base;
  String? $id;
  String? $schema;
  String? title;
  String? description;
  String? ownerId;
  List<String>? images;
  ///
  /// Schema Data
  Map<String, dynamic>? properties;

  static List<Map<String, dynamic>>? tmpList;

  SchemasModel(){

    // super;
  }

  /// Json That Modeling Details From Issuer 
  SchemasModel.fromJson(Map<String, dynamic> data) : super.fromJson(data) {
    $id = data['details']['did'];
    $schema = data['details']['schema'];
    title = data['details']['title'];
    description = data['details']['description'];
    ownerId = data['details']['ownerId'];
    images = List<String>.from(data['details']['images']);
    properties = data['details']['properties'];
    base = super.getOrg;
  }

  // For Any Drop Down
  static List<Map<String, dynamic>> toListMap(List<SchemasModel> ls){
    tmpList = [];
    for(SchemasModel schema in ls){
      tmpList!.add({
        "id": schema.$id,
        "schema": schema.$schema,
        "title": schema.title,
        "description": schema.description,
        "ownerId": schema.ownerId,
        "base": schema.toJson(schema)
      });
    }

    return tmpList!;
  }

  static List<Map<String, dynamic>> dropDownValue(List<SchemasModel> ls){
    tmpList = [];
    for(SchemasModel schema in ls){
      tmpList!.add({
        "display_value": schema.title,
        "value": schema.did,
      });
    };

    return tmpList!;
  }
}