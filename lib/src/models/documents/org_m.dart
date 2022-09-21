class OrgModel {

  int? did;
  String? cid;
  String? owner;
  int? ctype; 
  int? state; 
  int? parent; 
  Map<String, dynamic>? details;

  OrgModel(){}

  /// Json That Modeling of Organization
  OrgModel.fromJson(Map<String, dynamic> data){
    
    did = data['did'];
    cid = data['cid'];
    owner = data['owner'];
    ctype = data['ctype'];
    state = data['state'];
    parent = data['parent'];
    details = data['details'];
  }

  /// OrgModel Data To Json
  Map<String, dynamic> toJson(OrgModel org){
    return {
      "did": org.did,
      "cid": org.cid,
      "owner": org.owner,
      "ctype": org.ctype,
      "state": org.state,
      "parent": org.parent,
      "details": org.details
    };
  }

  OrgModel get getOrg => this;
}