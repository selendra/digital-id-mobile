


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/backend/post_request.dart';
import 'package:wallet_apps/src/components/dialog_c.dart';
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

class _CreateDocumentState extends State<CreateDocument> with TickerProviderStateMixin {

  DocumentProvider? _docProvider;

  bool? isImageAvailable = false;

  int? initValue;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _offsetAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  
  Future<void> mintCredential(String pin) async {

    try {
      
      // if (isImage()!){

      //   ApiProvider _apiProvider = await Provider.of<ApiProvider>(context, listen: false);
      //   await _apiProvider.apiKeyring.getDecryptedSeed(_apiProvider.getKeyring, pin).then((res) async {
      //     if (res!.seed != null){
      //       // await DialogComponents().seedDialog(context: context, contents: res.seed.toString(), isDarkTheme: isDarkTheme);
      //       Map<String, dynamic> obj = {};

      //       dialogLoading(context, content: "Minting document");
            
      //       Provider.of<DocumentProvider>(context, listen: false).lsIssuerProp!.forEach((element) {
              
      //         if (element['widget'].containsKey('formController')) 
      //         obj.addAll({
      //           "${element['key']}": element['widget']['formController'].text
      //         });

      //         else if (element['widget'].containsKey('image_hash'))
      //         obj.addAll({
      //           "${element['key']}": ["${dotenv.get(AppConfig.kmdFileApi)}/${element['widget']['image_hash'][0]}"]
      //         });

      //       });

      //       await Provider.of<ApiProvider>(context, listen: false).mintCredential(context, json.encode(obj), await Provider.of<DocumentProvider>(context, listen: false).schemaDocs!.did!, res.seed!).then((value) async {
              
      //         // Remove DialogLoading
      //         Navigator.pop(context);
      //         if (value == true){
      //           await DialogComponents().dialogCustom(context: context, contents: "Document is minted", titles: "Successfuly", btn2: TextButton(
      //             onPressed: (){
      //               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      //             }, 
      //             child: MyText(
      //               text: "Home",
      //                 fontWeight: FontWeight.w700,
      //               )
      //             )
      //           );
      //         } else {
      //           await DialogComponents().dialogCustom(context: context, contents: "Something went wrong", titles: "Oops");
      //         }
      //       });
      //     } else {
      //       await DialogComponents().dialogCustom(context: context, titles: "Oops", contents: "Invalid PIN", isDarkTheme: false);
      //     }
      //   });

      // } else {
      //   await DialogComponents().dialogCustom(context: context, contents: "Please fill out fields", titles: "Oops");
      // }

    } catch (e) {

      // Remove DialogLoading
      Navigator.pop(context);
      await DialogComponents().dialogCustom(context: context, contents: "Something went wrong", titles: "Oops");
    }
  }
  
  void queryPropByOwer() async {
    await _docProvider!.queryDocByOwerAddr(ownerAddr: widget.ownerId);
  }

  void resetField() {
  }

  bool? isImage(){
    for (var element in Provider.of<DocumentProvider>(context, listen: false).lsIssuerProp!){
      if (element['widget'].containsKey('image_hash')){
        if (element['widget']['image_hash'].length != 0)
        isImageAvailable = true;
      }
    }
    return isImageAvailable;
  }

  Future pickImage(int index) async {
    try {
      _docProvider!.lsIssuerProp![index]['widget']['image_hash'] = [];
      _docProvider!.lsIssuerProp![index]['widget']['image'] = [];
      // if (label == 'back'){
      //   widget.model!.backFaceImage = img;
      // } else {
        
      //   widget.model!.selfieImage = img;
      // }

      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
      // print("file ${file!.path}");
      // await _docProvider!.addJson(json, url, schemaID)
      _docProvider!.lsIssuerProp![index]['widget']['image'].add(file!.path);

      await PostRequest().upLoadImage(File(file.path)).then((value) async {
        _docProvider!.lsIssuerProp![index]['widget']['image_hash'].add(await json.decode(value)['Hash']);
      });

      // await Provider.of<ApiProvider>(context, listen: false).getSdk.webView!.evalJavascript("addJson.uploadImage('${file.path}', '${dotenv.get(AppConfig.kmdApi)}', '${await Provider.of<DocumentProvider>(context, listen: false).schemaDocs!.did!}')").then((value) {
      //   print("Hello $value");
      // });

      setState(() { });
    } catch (e){
      print("Error pickImage $e");
    }
  }


  /// Search Schemas By Organization Id 
  /// 
  /// And Pass Data To SchemaModel.fromJson
  void searchAndFilter(int? did){
    print("searchAndFilter");
    print("_docProvider!.lsSchmDocs![0].did ${_docProvider!.lsSchmDocs![0].did}");
    _docProvider!.schemaDocs = SchemasModel.fromJson(SearchUtils.searchOrgByOwnerId(context, widget.ownerId, did));
    print("lsSchmDocs ${_docProvider!.lsSchmDocs ?? 'hello'}");

    _docProvider!.propModeling();
  }

  /// Value Change DropDown
  void onChanged(int? value){

    setState(() {
      initValue = value!;
    });

    searchAndFilter(value);
  }
  
  @override
  initState(){
    
    _docProvider = Provider.of<DocumentProvider>(context, listen: false);

    /// Initalize Drop Down Value With Title Of First Schema
    initValue = _docProvider!.lsSchmDocs![0].did;
    print("initValue $initValue");
    searchAndFilter(_docProvider!.lsSchmDocs![0].did!);
    // queryPropByOwer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreateIDBody(
      initValue: initValue,
      resetField: resetField,
      pickImage: pickImage,
      onChanged: onChanged,
      mintCredential: mintCredential
    );
  }
}