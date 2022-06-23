// import 'package:wallet_apps/core/config/app_config.dart';

import 'package:wallet_apps/index.dart';

class DashBoardModel {
  
  String profile = 'https://icon-library.com/images/student-icon-png/student-icon-png-9.jpg';
  // String cover = AppConfig.imagePath+"cover.jpg";//'https://media.istockphoto.com/vectors/back-to-school-seamless-pattern-from-education-science-objects-vector-id692479436?k=20&m=692479436&s=612x612&w=0&h=6ZBQ08aqP_xqmS4oeOffARBd-9pbm3f9xTJpHPgr-WM=';

  String name = '';
  String email = '';
  String dob = '';
  String nationality = '';
  String phoneNum = '';
  String country = '';
  bool isEditing = false;
  bool isInit = false;

  String titlePage = "Basic Info";
  String wallet = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  initData(){

    name = "";
    email = "";
    nationality = "";
    phoneNum = "";
    nameController.text = "";
  
    emailController.text = "";
    nationalityController.text = "";
    phoneNumController.text = "";
    isInit = true;
  }

}