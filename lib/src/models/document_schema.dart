import 'package:wallet_apps/src/models/documents/org_m.dart';

class DocumentSchema {

  String? type;
  List? docsList;
  List<dynamic>? docsProperty;
  List<OrgModel>? lsOrg;
  
  DocumentSchema({this.type, this.docsList, this.docsProperty, this.lsOrg});
}

class DocumentProperty{

  String? title;
  String? image;
  String? color;
  
  DocumentProperty({this.title, this.image, this.color});
}