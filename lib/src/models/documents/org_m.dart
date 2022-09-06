class OrgModel {

  int? did;
  String? cid;
  String? owner;
  int? ctype; 
  int? state; 
  int? parent; 
  Map<String, dynamic>? details;

  /// Json That Modeling of Organization
  OrgModel.fromJson(Map<String, dynamic> data){

    print("data['did'] ${data['did'].runtimeType}");
    print("data['cid'] ${data['cid'].runtimeType}");
    print("data['owner'] ${data['owner'].runtimeType}");
    print("data['ctype'] ${data['ctype'].runtimeType}");
    print("data['state'] ${data['state'].runtimeType}");
    print("data['parent'] ${data['parent'].runtimeType}");
    print("data['details'] ${data['details'].runtimeType}");
    
    did = data['did'];
    cid = data['cid'];
    owner = data['owner'];
    ctype = data['ctype'];
    state = data['state'];
    parent = data['parent'];
    details = data['details'];

    print("end filter");
  }
}