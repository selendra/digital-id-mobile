

import 'package:carousel_slider/carousel_options.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/backend/post_request.dart';
import 'package:wallet_apps/src/components/camera_c.dart';
import 'package:wallet_apps/src/components/dialog_c.dart';
import 'package:wallet_apps/src/constants/db_key_con.dart';
import 'package:wallet_apps/src/models/digital_id_m.dart';
import 'package:wallet_apps/src/provider/digital_id_p.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/provider/home_p.dart';
import 'package:wallet_apps/src/screen/home/home_page/body_home.dart';
import 'package:wallet_apps/src/service/services_s.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:encrypt/encrypt.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {

  static final String route = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with TickerProviderStateMixin {
  
  late TabController _tabBarController;

  final _selectedColor = hexaCodeToColor(AppColors.newPrimary);
  
  TextEditingController phraseKey = TextEditingController();
  DashBoardModel _dashBoardM = DashBoardModel();
  TabController? _tabController;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  
  CTypeModel cTypeModel = CTypeModel();

  DocumentProvider? _docsProvider;

  final JsonDecoder decoder = JsonDecoder();

  ApiProvider? _api;

  // -------------------
  HomePageModel _model = HomePageModel();

  @override
  void initState() {

    _tabBarController = TabController(length: 2, vsync: this);
    
    _model.pageController = PageController(initialPage: 1);

    _model.pageController!.addListener(() {
      if(_model.activeIndex != _model.pageController){
        setState(() {
          _model.activeIndex = _model.pageController!.page!.toInt();
        });
      }
    });

    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      onTab(_tabController!.index);
    });

    _model.activeIndex = 1;
    _model.carouActiveIndex = 0;
    _model.globalKey = GlobalKey<ScaffoldState>();
    _model.onCarouselChanged = (int index, CarouselPageChangedReason reason) {
      setState(() {
        this._model.carouActiveIndex = index;
      });
    };

    _dashBoardM = Provider.of<HomeProvider>(context, listen: false).homeModel;
    _docsProvider = Provider.of<DocumentProvider>(context, listen: false);
    _api = Provider.of<ApiProvider>(context, listen: false);

    _docsProvider!.initContext = context;
    _docsProvider!.initField();

    fetchOrganization();
    
    jsonValidator();

    super.initState();
  }

  void fetchOrganization() async {

    await _docsProvider!.initIssuer();

    print("finish initIssuer");
    
    await _docsProvider!.initJson();

    print("finish initJson");

    await StorageServices.fetchData(DbKey.lsDocs).then((data) async {

      print("data $data");
      if (data != null){
        print("data['credentials'] ${data['credentials']}");
        for (var element in data['credentials']){
          print("element $element");
          _docsProvider!.assetsMinted!.add(element);
        }

        await StorageServices.fetchData(DBkey.datas).then((value) {
          if (value != null){

            _docsProvider!.object = value;

            _docsProvider!.orgFilter();

            _docsProvider!.userDocsDataFilter();
          }
        });
      } 
    });

    setState(() {});

    await _docsProvider!.queryAllOrgs();

    print("finish queryAllOrgs");
    
    _docsProvider!.orgFilter();

    print("finish orgFilter");

    await _docsProvider!.queryAssetOf();

    print("finish queryAssetOf");
    // _docsProvider!.schemaFilter();
    // _docsProvider!.schemaFilter();
    // _docsProvider!.credentialsFilter();

    // print("_docsProvider ${_docsProvider!.lsOrgDocs}");
    // print("_docsProvider ${_docsProvider!.lsCredentailDocs}");
  }

  void fetchSelendraID() async {
    await StorageServices.fetchData(DbKey.selendraID).then((value) {
      if (value != null) _model.isSelendraID = value;
      else Provider.of<DocumentProvider>(context, listen: false).initSelendraDocs();
    });
  }

  void onPageChanged(int index){
    setState(() {
      _model.activeIndex = index;
    });
    _model.pageController!.jumpToPage(index);
    //  else {

    //   underContstuctionAnimationDailog(context: context);
    // }
    // _model.pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  final bool? pushReplacement = true;
  // -------------------

  Future pickImage(ImageSource source, String? label) async {
    print("pickImage");
    XFile? pickedFile;
    if (source == ImageSource.camera){
      pickedFile = await Navigator.push(context, MaterialPageRoute(builder: (context) => CameraApp()));
    } else {
      pickedFile = await MyAppServices.pickImage(source);
    }

    if (pickedFile != null){
      setState(() {
        if (label == 'cover'){
          // _dashBoardM.cover = pickedFile!.path;
        } else {

          _dashBoardM.profile = pickedFile!.path;
        }
      });
    }
    
  }
  
  void edit(){
    setState(() {
      _dashBoardM.isEditing = !_dashBoardM.isEditing;
      if (_dashBoardM.isEditing == false) resetEdit();
    });
  }

  void resetEdit(){
    setState(() {
      _dashBoardM.nameController.text = _dashBoardM.name;
      _dashBoardM.emailController.text = _dashBoardM.email;
      _dashBoardM.nationalityController.text = _dashBoardM.nationality;
      _dashBoardM.phoneNumController.text = _dashBoardM.phoneNum;
    });
  }

  void onTab(int index){
    setState(() {
      if (index == 0){
        _dashBoardM.titlePage = "Basic Info";
      } else if (index == 1) {
        String _wallet = Provider.of<HomeProvider>(context, listen: false).homeModel.wallet;
        if (_wallet != ""){
          _dashBoardM.titlePage = "Your wallet address";
        }
      } else {
        _dashBoardM.titlePage = "Link Accounts";
      }
    });
  }

  // When Account Already Mint
  initBlockchainData() async {
    await StorageServices.fetchData(DbKey.blochchainData).then((value) async {
      print("blochchainData $value");
      if (value != null){
        Provider.of<HomeProvider>(context, listen: false).setSuccessSubmitToBlockchain = true;
      } else {
        Provider.of<HomeProvider>(context, listen: false).setSuccessSubmitToBlockchain = false;
      }
      print("Provider.of<HomeProvider>(context, listen: false).successSubmitToBlockchain ${Provider.of<HomeProvider>(context, listen: false).successSubmitToBlockchain}");
    });
  }

  void submitEdit() async {
    
    _dashBoardM.name = _dashBoardM.nameController.text;
    _dashBoardM.email = _dashBoardM.emailController.text;
    _dashBoardM.nationality = _dashBoardM.nationalityController.text;
    _dashBoardM.phoneNum = _dashBoardM.phoneNumController.text;
    _dashBoardM.country = _dashBoardM.countryController.text;
    _dashBoardM.dob = _dashBoardM.dobController.text;
    _dashBoardM.isEditing = false;

    print(_dashBoardM.name);
    print(_dashBoardM.email);
    print(_dashBoardM.nationality);
    print(_dashBoardM.phoneNum);
    print(_dashBoardM.country);
    print(_dashBoardM.dob);
    print(_dashBoardM.isEditing);

  }

  Future<void> _scanLogin(dynamic code) async {

    try {
      dynamic decode = jsonDecode(code);

      if (decode != null && (decode.containsKey("id") && decode.containsKey("url") && decode.containsKey("link") )){

        await Navigator.push(context, MaterialPageRoute(builder: (context) => Passcode(label: PassCodeLabel.fromMint))).then((value) async {
          // await disableScreenShot!();

          dialogLoading(context, content: "Logging in");
          print("value $value");
          if (value != null) {

            final _mnemonic = await _api!.apiKeyring.getDecryptedSeed(_api!.getKeyring, value);

            if (_mnemonic!.seed != null){

              final Map<dynamic, dynamic> decode = decoder.convert(code);

              if(decode["id"] == null) {
              
                // Close Loading
                Navigator.pop(context);
                
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text("Invalid ID Not Found"),
                    actions: [
                      MyFlatButton(
                        textButton: "Ok",
                        buttonColor: AppColors.newPrimary,
                        action: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                );
              } 
              else{
                List<int> convert = decode['id'].toString().codeUnits;
                Uint8List uint8list = Uint8List.fromList(convert);
                String _credentials = await _signId(decode['id'], _mnemonic.seed!);
                
                // Sign Message
                final message = await _api!.getSdk.webView!.evalJavascript("accBinding.signMessage('${decode['id']}', '$_credentials')");
                
                await PostRequest().scanLogin( decode['id'], message, decode['link'], Provider.of<ContractProvider>(context, listen: false).ethAdd );
                
                // Close Dialog Loading
                Navigator.pop(context);

                await DialogComponents().dialogCustom(context: context, contents: "Successfully login");

              }
            } else {

              // Close Loading
              Navigator.pop(context);
              await DialogComponents().dialogCustom(context: context, contents: "Incorrect pin", titles: "Oops");
            }
          }
          
        });

      }

    } catch (e) {
      
      await DialogComponents().dialogCustom(context: context, contents: "Invalid qr code", titles: "Oops");
    }
  }

  Future<String> _signId(dynamic id, String mnemonic) async {
    return await Provider.of<ApiProvider>(context, listen: false).getPrivateKey(mnemonic);

  }

  Future<void> _deleteAccount() async {

    dialogLoading(context);

    final _api = await Provider.of<ApiProvider>(context, listen: false);
    
    try {
      await _api.apiKeyring.deleteAccount(
        _api.getKeyring,
        Provider.of<ApiProvider>(context, listen: false).getKeyring.current,
      );

      final mode = await StorageServices.fetchData(DbKey.themeMode);
      // final event = await StorageServices.fetchData(DbKey.event);

      await StorageServices().clearStorage();

      // Re-Save Them Mode
      await StorageServices.storeData(mode, DbKey.themeMode);
      // await StorageServices.storeData(event, DbKey.event);

      await StorageServices().clearSecure();
      
      Provider.of<ContractProvider>(context, listen: false).resetConObject();

      await Future.delayed(Duration(seconds: 2), () {});
      
      Provider.of<WalletProvider>(context, listen: false).clearPortfolio();

      Navigator.pushAndRemoveUntil(context, RouteAnimation(enterPage: Welcome()), ModalRoute.withName('/'));
    } catch (e) {
      if (ApiProvider().isDebug == true) print("_deleteAccount ${e.toString()}");
      // await dialog(context, e.toString(), 'Opps');
    }
  }

  void bindAcc() async {

    // await PostRequest().claimAirDrop("seZe6HkLx3FXay1zMeMm1q1DXsYavmZNacV3wKon63uUPeAaS");
    // final ApiProvider api = Provider.of<ApiProvider>(context, listen: false);

    // String _pk = await api.getPrivateKey('dentist body neglect clay stage forget caught bacon moment gown toast kind');

    // await api.getSdk.webView!.evalJavascript("accBinding.bindAccount('dentist body neglect clay stage forget caught bacon moment gown toast kind', '${_pk}', '${ ApiProvider().isMainnet ? AppConfig.networkList[0].wsUrlMN : AppConfig.networkList[0].wsUrlTN}', '${ ApiProvider().isMainnet ? AppConfig.networkList[0].wsUrlMN : AppConfig.networkList[0].wsUrlTN}') ");
  }

  void jsonValidator() async {
    print("jsonValidator");
    final workivaLocations = [
      {
        'name': 'Ames',
        'latitude': 41.9956731,
        'longitude': -93.6403663,
      },
      {
        'name': 'Scottsdale',
        'latitude': 33.4634707,
        'longitude': -111.9266617,
      }
    ];

    // final schema = await JsonSchema.createSchemaAsync({
    //   'type': 'array',
    //   'items': {r'$ref': 'https://json-schema.org/draft/2020-12/schema'}
    // });

    // print(schema.validate(workivaLocations));
  }

  @override
  void dispose() {
    
    _tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: HomeBody(
        homePageModel: _model,
        onPageChanged: onPageChanged,
        pushReplacement: pushReplacement,
        // queryCType: queryCType,
        cTypeModel: cTypeModel,
        tabBarController: _tabBarController,
        selectedColor: _selectedColor,
        scanLogin: _scanLogin,
        deleteAccount: _deleteAccount,
        bindAcc: bindAcc
        // dashModel: _dashBoardM,
        // onTab: onTab,
        // tabController: _tabController,
        // edit: edit, 
        // // pickImage: pickImage, 
        // submitEdit: submitEdit,
        // scaffoldKey: globalKey,
      )
    );
  }
}
