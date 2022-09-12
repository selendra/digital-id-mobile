


import 'package:image_picker/image_picker.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/api/api.dart';
import 'package:wallet_apps/src/models/documents/schemas_m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/create_document/body_create_body.dart';
import 'package:wallet_apps/src/utils/search_utl.dart';

class CreateDocument extends StatefulWidget {

  final String? ownerId;

  CreateDocument({Key? key, required this.ownerId}) : super(key: key);

  @override
  State<CreateDocument> createState() => _CreateDocumentState();
}

class _CreateDocumentState extends State<CreateDocument> {

  DocumentProvider? _docProvider;
  
  Future<void> mintCredential() async {

    Map<String, dynamic> obj = {};
    
    Provider.of<DocumentProvider>(context, listen: false).lsIssuerProp!.forEach((element) {
      if (element['widget'].containsKey('formController')) print("element['widget']['formController'] ${element['widget']['formController'].text}");
      obj.addAll({
        "${element['key']}": element['widget'].containsKey('formController') ? element['widget']['formController'].text : element['widget']['image'][0]
      });
    });
    // print(obj);
    await _docProvider!.addJson(
      json.encode(obj),
      Api.ipfsApi,
      _docProvider!.schemaDocs!.did!
    );

    // await Provider.of<ApiProvider>(context, listen: false).mintCredential(json.encode(obj), await Provider.of<DocumentProvider>(context, listen: false).schemaDocs!.did!);
    
    // bool isEmpty = false;
    // for(int i = 0; i < widget.docs!.length; i++){
    //   if (widget.docs![i]['formController'].text == ""){
    //     isEmpty = true;
    //     break;
    //   }
    // }

    // if (isEmpty){
      
    // }
  }
  
  void queryPropByOwer() async {
    await _docProvider!.queryDocByOwerAddr(ownerAddr: widget.ownerId);
  }

  void resetField() {
  }


  Future pickImage(int index) async {
    print("pickImage");
    try {
      // if (label == 'back'){
      //   widget.model!.backFaceImage = img;
      // } else {
        
      //   widget.model!.selfieImage = img;
      // }

      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
      print("file ${file!.path}");
      Provider.of<DocumentProvider>(context, listen: false).lsIssuerProp![index]['widget']['image'].add(file.path);

      setState(() { });
    } catch (e){
      print("Error pickImage $e");
    }
  }


  /// Search Schemas By Organization Id 
  /// 
  /// And Pass Data To SchemaModel.fromJson
  void searchNFilter(){
    print("searchNFilter");
    _docProvider!.schemaDocs = SchemasModel.fromJson(SearchUtils.searchOrgByOwnerId(context, widget.ownerId));

    _docProvider!.propModeling();
  }
  
  @override
  initState(){
    // print("widget.ownerId ${widget.ownerId}");
    _docProvider = Provider.of<DocumentProvider>(context, listen: false);
    searchNFilter();
    // queryPropByOwer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreateIDBody(
      resetField: resetField,
      pickImage: pickImage,
      mintCredential: mintCredential
    );
  }
}