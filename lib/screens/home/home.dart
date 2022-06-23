import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/camera_c.dart';
import 'package:digital_id/components/text_c.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/main.dart';
import 'package:digital_id/models/dashboard_m.dart';
import 'package:digital_id/models/digital_id_m.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/provider/digital_id_p.dart';
import 'package:digital_id/provider/registration_p.dart';
import 'package:digital_id/screens/home/body_home.dart';
import 'package:digital_id/services/services_s.dart';
import 'package:digital_id/services/storage.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  
  TextEditingController phraseKey = TextEditingController();
  DashBoardModel _dashBoardM = DashBoardModel();
  TabController? _tabController;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  DigitalIDProvider? _digitalIDProvider;

  Future pickImage(ImageSource source, String? label) async {
    print("pickImage");
    XFile? pickedFile;
    if (source == ImageSource.camera){
      pickedFile = await Navigator.push(context, MaterialPageRoute(builder: (context) => CameraApp()));
    } else {
      pickedFile = await AppServices.pickImage(source);
    }

    if (pickedFile != null){
      setState(() {
        if (label == 'cover'){
          _dashBoardM.cover = pickedFile!.path;
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

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      onTab(_tabController!.index);
    });
    _dashBoardM = Provider.of<HomeProvider>(context, listen: false).homeModel;
    _digitalIDProvider = Provider.of<DigitalIDProvider>(context, listen: false);
    // StorageServices.removeKey(DbKey.idKey);
    initBlockchainData();
    // initDigitalId();

    super.initState();
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
    await Provider.of<DigitalIDProvider>(context, listen: false).fetchID().then((value) {
      print("value");
    });

    await StorageServices.fetchData(DbKey.sensitive).then((value) async {
      print("sensitive $value");
      if (value != null){

        Map<String, dynamic> data = await json.decode(Encryption().decryptAES(value));
        print("data ${data}");

        _dashBoardM.name = data['name'] == "" || data['name'] == null ? "" : data['name'];
        _dashBoardM.email = data['email'] == "" || data['email'] == null ? "" : data['email'];
        _dashBoardM.dob = data['dob'] == "" || data['dob'] == null ? "" : data['dob'];
        _dashBoardM.nationality = data['nationality'] == "" || data['nationality'] == null ? "" : data['nationality'];
        _dashBoardM.phoneNum = data['phoneNum'] == "" || data['phoneNum'] == null ? "" : data['phoneNum'];
        _dashBoardM.country = data['country'] == "" || data['country'] == null ? "" : data['country'];

        _dashBoardM.nameController.text = data['name'] == "" || data['name'] == null ? "" : data['name'];
        _dashBoardM.emailController.text = data['email'] == "" || data['email'] == null ? "" : data['email'];
        _dashBoardM.dobController.text = data['dob'] == "" || data['dob'] == null ? "" : data['dob'];
        _dashBoardM.nationalityController.text = data['nationality'] == "" || data['nationality'] == null ? "" : data['nationality'];
        _dashBoardM.phoneNumController.text = data['phoneNum'] == "" || data['phoneNum'] == null ? "" : data['phoneNum'];
        _dashBoardM.countryController.text = data['country'] == "" || data['country'] == null ? "" : data['country'];

        _digitalIDProvider!.isAbleSubmitToBlockchain(context: context);
      }
      
    });
    setState(() { });
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

    Provider.of<DigitalIDProvider>(context, listen: false).isAbleSubmitToBlockchain(context: context);
    _digitalIDProvider!.setBlockChainData = _digitalIDProvider!.toJson(_dashBoardM);
    Encrypted _encrypted = Encryption().encryptAES(json.encode(_digitalIDProvider!.toJson(_dashBoardM)));
    await StorageServices.storeData(_encrypted.bytes, DbKey.sensitive);

    setState(() {
      _dashBoardM.isEditing = false;
    });
  }

  void prepareEncryption() async {
    ApiProvider _apiProvider = Provider.of<ApiProvider>(context, listen: false);

    EncryptionRSA encryptionRSA = EncryptionRSA();

    // encryptionRSA.encryptRSA(txt);
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: DashBoardBody(
        dashModel: _dashBoardM,
        onTab: onTab,
        tabController: _tabController,
        edit: edit, 
        // pickImage: pickImage, 
        submitEdit: submitEdit,
        scaffoldKey: globalKey,
      )
    );
  }
}
