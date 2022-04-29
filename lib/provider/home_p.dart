import 'package:student_id/all_export.dart';

class HomeProvider with ChangeNotifier{

  DashBoardModel homeModel = DashBoardModel();

  bool successSubmitToBlockchain = false;
  bool readyToSubmit = false;

  set setWallet(String value) {
    homeModel.wallet = value;
    // notifyListeners();
  }

  set setSuccessSubmitToBlockchain(bool value) {
    successSubmitToBlockchain = value;
    notifyListeners();
  }

  HomeProvider(){
    if(homeModel.isInit == false) homeModel.initData();
    notifyListeners();
  }

  void submitEdit(DashBoardModel model){

    homeModel.email = model.emailController.text;
    homeModel.country = model.country;
    homeModel.dob = model.dob;
    homeModel.name = model.nameController.text;
    homeModel.nationality = model.nationalityController.text;
    homeModel.phoneNum = model.phoneNumController.text;
    homeModel.cover = model.cover;  
    homeModel.profile = model.profile;
    notifyListeners();
  }

  void notify(){
    notifyListeners();
  }
}