

import 'package:carousel_slider/carousel_options.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/camera_c.dart';
import 'package:wallet_apps/src/constants/db_key_con.dart';
import 'package:wallet_apps/src/models/digital_id_m.dart';
import 'package:wallet_apps/src/models/kyc_content_m.dart';
import 'package:wallet_apps/src/provider/digital_id_p.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/provider/home_p.dart';
import 'package:wallet_apps/src/screen/home/home/body_home.dart';
import 'package:wallet_apps/src/screen/home/home_page/body_home.dart';
import 'package:wallet_apps/src/service/http_request/get_request.dart';
import 'package:wallet_apps/src/service/http_request/post_request.dart';
import 'package:wallet_apps/src/service/services_s.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
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
  DigitalIDProvider? _digitalIDProvider;
  CTypeModel cTypeModel = CTypeModel();

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

    _model.activeIndex = 1;
    _model.carouActiveIndex = 0;
    _model.globalKey = GlobalKey<ScaffoldState>();
    _model.onCarouselChanged = (int index, CarouselPageChangedReason reason) {
      setState(() {
        this._model.carouActiveIndex = index;
      });
    };

    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      onTab(_tabController!.index);
    });
    _dashBoardM = Provider.of<HomeProvider>(context, listen: false).homeModel;
    _digitalIDProvider = Provider.of<DigitalIDProvider>(context, listen: false);
    // StorageServices.removeKey(DbKey.idKey);
    // initBlockchainData();
    initDigitalId();

    fetchSelendraID();

    super.initState();
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

  /// For Check Identity Setup (National ID, Student)
  initDigitalId() async {
    print("initDigitalId");
    
    // await Provider.of<ContractProvider>(context, listen: false).orgsList();  
    // print("initDigitalId");
    // await Provider.of<DigitalIDProvider>(context, listen: false).fetchID().then((value) {
    //   print("value");
    // });

    // await StorageServices.fetchData(DbKey.sensitive).then((value) async {
    //   print("sensitive $value");
    //   if (value != null){

    //     Map<String, dynamic> data = await json.decode(Encryption().decryptAES(value));
    //     print("data ${data}");

    //     _dashBoardM.name = data['name'] == "" || data['name'] == null ? "" : data['name'];
    //     _dashBoardM.email = data['email'] == "" || data['email'] == null ? "" : data['email'];
    //     _dashBoardM.dob = data['dob'] == "" || data['dob'] == null ? "" : data['dob'];
    //     _dashBoardM.nationality = data['nationality'] == "" || data['nationality'] == null ? "" : data['nationality'];
    //     _dashBoardM.phoneNum = data['phoneNum'] == "" || data['phoneNum'] == null ? "" : data['phoneNum'];
    //     _dashBoardM.country = data['country'] == "" || data['country'] == null ? "" : data['country'];

    //     _dashBoardM.nameController.text = data['name'] == "" || data['name'] == null ? "" : data['name'];
    //     _dashBoardM.emailController.text = data['email'] == "" || data['email'] == null ? "" : data['email'];
    //     _dashBoardM.dobController.text = data['dob'] == "" || data['dob'] == null ? "" : data['dob'];
    //     _dashBoardM.nationalityController.text = data['nationality'] == "" || data['nationality'] == null ? "" : data['nationality'];
    //     _dashBoardM.phoneNumController.text = data['phoneNum'] == "" || data['phoneNum'] == null ? "" : data['phoneNum'];
    //     _dashBoardM.countryController.text = data['country'] == "" || data['country'] == null ? "" : data['country'];

    //     _digitalIDProvider!.isAbleSubmitToBlockchain(context: context);
    //   }
      
    // });
    // setState(() { });
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

    // Provider.of<DigitalIDProvider>(context, listen: false).isAbleSubmitToBlockchain(context: context);
    // _digitalIDProvider!.setBlockChainData = _digitalIDProvider!.toJson(_dashBoardM);
    // Encrypted _encrypted = Encryption().encryptAES(json.encode(_digitalIDProvider!.toJson(_dashBoardM)));
    // await StorageServices.storeData(_encrypted.bytes, DbKey.sensitive);

    // setState(() {
    //   _dashBoardM.isEditing = false;
    // });
  }

  void prepareEncryption() async {
    // ApiProvider _apiProvider = Provider.of<ApiProvider>(context, listen: false);

    // EncryptionRSA encryptionRSA = EncryptionRSA();

    // encryptionRSA.encryptRSA(txt);
    
  }

  queryCType(BigInt orgID) async {
    print("queryCType $orgID");
    await Provider.of<ContractProvider>(context, listen: false).queryDigitalID("_CtypeMetadata", [orgID]).then((value) async {
      List.from(value).forEach((data){
        print("_CtypeMetadata ${data}}");
      });
      cTypeModel = CTypeModel().fromQuery(List.from(value));
      
      await http.get(Uri.parse(cTypeModel.propertiesURI!)).then((res) async {
        print("propertiesURI res ${res.body}");
        dynamic data = await json.decode(res.body);
        print("data ${data['properties']}");
        cTypeModel.cTypeProperties = CTypeModel().cTypePropertiesFilter(data);
        // print("cTypeModel.cTypeProperties ${cTypeModel.cTypeProperties!['properties']}");
      });
    });
  }

  Future<void> _scanLogin(String code) async {

                    
    final String? barcodeData = code;

    final decode = jsonDecode(barcodeData!);
    print("_scanLogin decode $decode");
    if(decode["id"] == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Invalid QR Code"),
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
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Message"),
          content: Text("Valid QR Code"),
          actions: [
            MyFlatButton(
              textButton: "Ok",
              buttonColor: AppColors.newPrimary,
              action: () async {

                List<int> convert = decode['id'].toString().codeUnits;
                Uint8List uint8list = Uint8List.fromList(convert);
                String _credentials = await _signId(decode['id']);
                print("_credentials $_credentials");
                String signedDataHex = EthSigUtil.signMessage(
                  privateKey: _credentials,
                  message: uint8list
                );
                print("signedDataHex $signedDataHex");
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }

  }

  Future<String> _signId(String id) async {

    return await Provider.of<ApiProvider>(context, listen: false).getPrivateKey("august midnight obvious fragile pretty begin useless collect elder ability enhance series");

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
        queryCType: queryCType,
        cTypeModel: cTypeModel,
        tabBarController: _tabBarController,
        selectedColor: _selectedColor,
        scanLogin: _scanLogin,
        deleteAccount: _deleteAccount
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
