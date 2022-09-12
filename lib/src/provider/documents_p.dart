import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/api/api.dart';
import 'package:wallet_apps/src/models/documents/credential_m.dart';
import 'package:wallet_apps/src/models/documents/document_m.dart';
import 'package:wallet_apps/src/models/document_schema.dart';
import 'package:wallet_apps/src/models/documents/org_m.dart';
import 'package:http/http.dart' as _http;
import 'package:wallet_apps/src/models/documents/schemas_m.dart';
import 'package:wallet_apps/src/service/http_request/get_request.dart';

class DocumentProvider extends ChangeNotifier{

  _http.Response? _res;

  /// Object Contain All Organization
  Map<String, dynamic>? object;

  String? title;

  Map<String, dynamic>? mandotary;
  Map<String, dynamic>? selendra;
  Map<String, dynamic>? popular;
  Map<String, dynamic>? issuer;

  List<DocumentSchema>? lsDocs;
  List<OrgModel>? lsOrgDocs;
  List<CredentialModel>? lsCredentailDocs;
  // List Properties
  List<dynamic>? selendraID = [];
  List<dynamic>? lsMandotaryProp = [];
  List<dynamic>? lsPopularProp = [];
  List<dynamic>? lsIssuerProp = [];
  List<Map<String, dynamic>>? assetsMinted;

  DocumentModel docsModel = DocumentModel();
  SchemasModel? schemaDocs;

  BuildContext? context;

  ApiProvider? apiProvider;

  DocumentProvider(){

    // Initialize All Field
    initField();
    
    // Call Query Method
    queryAllOrgs();

    // docsModel.data = [
      // {
      //   "type": "National ID",
      //   "id": "1233452423",
      //   "name": "Sam Allen",
      //   "dob": "09.02.2000",
      //   "gender": "Female",
      //   "address": "Tik L'lork, Toul Kork, Phnom Penh",
      //   "status": "verifying",
      //   "isVeried": false,
      //   "color": "#D5ECC2",
      //   "height": "165",
      //   "identity": "Scar on the left side 1cm",
      //   "expired_date": "2022.01.21 - 2025.01.21",
      //   "isApprove": false
      // },
      // {
      //   "type": "Driver licence",
      //   "id": "1233452423",
      //   "name": "Sam Allen",
      //   "dob": "09.02.2000",
      //   "gender": "Male",
      //   "address": "Tik L'lork, Toul Kork, Phnom Penh",
      //   "status": "verifying",
      //   "isVeried": false,
      //   "color": "#98DDCA",
      //   "height": "175",
      //   "identity": "Scar on the left side 1cm",
      //   "expired_date": "2022.01.21 - 2025.01.21",
      //   "isApprove": true
      // },
      // {
      //   "type": "Covid Vaccination",
      //   "id": "1233452423",
      //   "name": "Sam Allen",
      //   "dob": "09.02.2000",
      //   "gender": "Male",
      //   "address": "Tik L'lork, Toul Kork, Phnom Penh",
      //   "status": "verified",
      //   "isVeried": true,
      //   "color": "#FFAAA7",
      //   "height": "188",
      //   "identity": "Scar on the left side 1cm",
      //   "expired_date": "2022.01.21 - 2025.01.21",
      //   "isApprove": false
      // }
    // ];

    userDocsDataFilter();

  }

  void initField(){

    lsOrgDocs = [];
    lsCredentailDocs = [];
    docsModel.data = [];
    lsDocs = [];
    assetsMinted = [];
    docsModel.pending = [];
    docsModel.approve = [];
    lsMandotaryProp = [];
    lsPopularProp = [];
    lsIssuerProp = [];

    popular = {};
    issuer = {};
  }

  /// Initialize context to user Provider  At HomePage
  void set initContext (BuildContext context) {
    this.context = context;
  }

  /// Run First;
  /// 
  /// From JSON
  void initIssuer() async {
    print("initIssuer");
    lsDocs = [];
    await rootBundle.loadString(AppConfig.docJson).then((value) async {
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
    });

    await initJson();

    orgFilter();
    
  }
  
  /// Init and filter property of document
  /// 
  /// Run Second
  Future<void> initJson() async {

    print("initJson");

    final jsonData = await rootBundle.loadString(AppConfig.mandatory);
    mandotary = json.decode(jsonData);
    
    // Add More Object Of Input Field
    popular = json.decode(jsonData);
    popular!['properties'].addAll({
      'city': {'type': 'string', 'description': "Battambang"}
    });

    // Add More Object Of Input Field
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

    // Map<String, dynamic>.from(issuer!['properties']).forEach((key, value) {
    //   lsIssuerProp!.add({
    //     'key': key,
    //     'value': value,
    //     'formController': TextEditingController(),
    //     'focusNode': FocusNode(),
    //     'type': value['type']
    //   });
    // });

    lsDocs![2].docsProperty = [];//lsIssuerProp!;

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

  /// Data Of User's Document Filter By Status
  void userDocsDataFilter(){
    // docsModel.data.forEach((element) {
    //   if (element['isApprove'] == false) {
    //     docsModel.pending.add(element);
    //   } else {
    //     docsModel.approve.add(element);
    //   }
    // });
    
    // docsModel.selendra.add({
    //   "type": "Selendar ID",
    //   "id": "1233452423",
    //   "name": "Sam Allen",
    //   "dob": "09.02.2000",
    //   "gender": "Male",
    //   "address": "Tik L'lork, Toul Kork, Phnom Penh",
    //   "status": "verified",
    //   "isVeried": true,
    //   "color": "#FFAAA7",
    //   "height": "188",
    //   "identity": "Scar on the left side 1cm",
    //   "expired_date": "2022.01.21 - 2025.01.21",
    //   "isApprove": false
    // });

    assetsMinted!.forEach((element) {
      print("assetsMinted each $element");
      if (element['isVerified'] == false) {
        docsModel.pending.add(element);
      } else {
        docsModel.approve.add(element);
      }
    });

    print("docsModel.pending ${docsModel.pending}");
    print("docsModel.approve ${docsModel.approve}");
    notifyListeners();
  }

  void notifyChanged(){
    notifyListeners();
  }

  /// -----------------------------From API-----------------------------
  ///
  /// Query All Data Of Organization
  /// 
  /// This Function Run Inside Home Before Navigate to Document Setup Screen
  Future<void> queryAllOrgs() async {
    print("queryListOfOrgs");
    try {
      // _res = await _http.get(Uri.parse(Api.allOrgApi));
      // object = json.decode(_res!.body);
      object = await json.decode(await rootBundle.loadString(AppConfig.docDidJson));
      print("object $object");
      
    } catch (e){
      print("Error queryListOfOrgs $e");
    }
    
  }

  Future<void> queryDocByOwerAddr({required String? ownerAddr}) async {
    print("queryDocByOwerAddr $ownerAddr");
    try {
      // _res = await _http.get(Uri.parse(Api.assetOf+"$ownerAddr"));
      // schemaFilter(json.decode(_res!.body));

      schemaFilter(object!);
    } catch (e){
      print("Error queryListOfOrgs $e");
    }
    
  }
  
  /// Collect only Organization
  void orgFilter(){
    print("orgFilter");
    if (lsDocs!.isNotEmpty){

      lsDocs![2].docsList = [];
      lsDocs![2].lsOrg = [];
      for (int i = 0; i < object!['organizations'].length; i++){

        // Fill Organzation
        lsOrgDocs!.add(
          OrgModel.fromJson(object!['organizations'][i])
        );
        lsDocs![2].lsOrg!.add(OrgModel.fromJson(object!['organizations'][i]));
        lsDocs![2].docsList!.add(
          lsOrgDocs![i].details
        );
      }
    }

  }

  /// Collect only Organization
  void schemaFilter(Map<String, dynamic> data){

    schemaDocs = SchemasModel.fromJson(data['schemas'][0]);
    
    // Fill Properties After Fill Schema Data
    propModeling();
  }

  /// Collect only Organization
  void credentialsFilter(Map<String, dynamic> data){
    
    for (int i = 0; i < data.length; i++){
      lsCredentailDocs!.add(
        CredentialModel.fromJson(data[i])
      );
    }
  }

  /// Modeling Properties for Issuer Or Organization
  void propModeling(){
    lsIssuerProp = [];

    schemaDocs!.properties!.entries.forEach((element) {
      
      lsIssuerProp!.add({
        'key': element.key,
        'value': element.value,
        'type': element.value['type'],
        if(element.value['type'] == "string" || element.value['type'] == "integer") 
        'widget': {
          'formController': TextEditingController(),
          'focusNode': FocusNode(),
          "key": element.key,
          "value": element.value
        }
        else if (element.value['type'] == "array" && element.value['label'] == "Images")
        'widget': {
          "image": List.empty(growable: true),
          "key": element.key,
          "value": element.value
        }
        else 
        'widget': {
          "key": element.key,
          "value": element.value
        }
        
        // 'widget': (element.value['type'] == "string" || element.value['type'] == "integer") ? {
        //   'formController': TextEditingController(),
        //   'focusNode': FocusNode(),

        // } : {
        //   "image": List.empty(growable: true),
        //   "key": element.key,
        //   "value": element.value
        // }
      });
    });

    print("lsIssuerProp $lsIssuerProp");
    // notifyListeners();
  }

  // void queryAssetOf() async {
  //   print("queryAssetOf");
  //   assetsMinted = [];
  //   Map<String, dynamic> data = {"credentials": [
  //     {
  //       "did": 2,
  //       "cid": "Qmc3hC7hW76fQeaePezq2vFPiW9eFCCHCoFGcG8Yujkd4r",
  //       "owner": "0x3Abb977B7301CA1c196F5795a3fd32A491061a71",
  //       "ctype": 2,
  //       "state": 0,
  //       "parent": 1,
  //       "isVerified": true,
  //       "details": {
  //         "name": "brilliant",
  //         "fullName": "Brilliant PHAL",
  //         "gender": "Male",
  //         "avatar": [
  //           "https://gateway.kumandra.org/files/QmSVLefQv53kNVNje2PS3kLo7qQteAGvQcWAPvqz5Ryr9v"
  //         ]
  //       }
  //     }
  //   ]};
  //   // await GetRequest().querySubmittedDocs(Provider.of<ContractProvider>(context!, listen: false).ethAdd).then((value) async {
  //     List<Map<String, dynamic>>.from(await data['credentials']).forEach((element) {
  //       assetsMinted!.add(element);
  //     });
  //   // });

  //   userDocsDataFilter();

  //   notifyListeners();
  // }
  
  /// -----------------------------Web3 Interaction-----------------------------
  /// 
  /// URL for KUMANDRA NTFS API
  Future<String> addJson(String json, String url, int schemaID) async {
    apiProvider = Provider.of<ApiProvider>(context!, listen: false);

    return await apiProvider!.getSdk.webView!.evalJavascript("addJson.addJson('$json', '$url', '$schemaID')");
  }
}