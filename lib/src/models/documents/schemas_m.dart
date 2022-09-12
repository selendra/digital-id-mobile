import 'package:wallet_apps/src/models/documents/org_m.dart';

class SchemasModel extends OrgModel {

  // Detail Properties
  String? $id;
  String? $schema;
  String? title;
  String? description;
  String? ownerId;
  List<String>? images;
  ///
  /// Schema Data
  Map<String, dynamic>? properties;

  /// Json That Modeling Details From Issuer 
  SchemasModel.fromJson(Map<String, dynamic> data) : super.fromJson(data) {
    
    print("From Schema $data");
    $id = data['details']['\$id'];
    $schema = data['details']['\$schema'];
    title = data['details']['title'];
    description = data['details']['description'];
    ownerId = data['details']['ownerId'];
    images = List<String>.from(data['details']['images']);
    properties = data['details']['properties'];

  }
}