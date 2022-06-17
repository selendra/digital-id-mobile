import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/models/digital_id_m.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/services/storage.dart';
class DigitalIDProvider extends ChangeNotifier{

  DigitalIDModel? identifierModel = DigitalIDModel();

  Map<String, dynamic>? _dataToBlockchain = {};
  
  Map<String, dynamic> get blochainData => _dataToBlockchain!;
  set setBlockChainData(Map<String, dynamic> data) => _dataToBlockchain!;

  set setSetup(bool value) {
    fetchID();
    notifyListeners();
  }

  /// This Function used for fetch Cache Digital ID
  Future<void> fetchID()async {

    await StorageServices.fetchData(DbKey.idKey).then((value) {
      if (value != null){
        identifierModel = DigitalIDModel().fromDb(value);
        print("value ${value}");
        print(identifierModel!.lsIDCard);
      }
    });
    notifyListeners();
  }

  bool isAbleSubmitToBlockchain({required BuildContext? context}){
    try {

      HomeProvider _api = Provider.of(context!, listen: false);
      print("identifierModel!.backImage ${identifierModel!.backImage ?? 'fuck'}");
      print("identifierModel!.frontImage ${identifierModel!.frontImage}");
      print("identifierModel!.selfieImage ${identifierModel!.selfieImage}");
      print("_api.homeModel.email ${_api.homeModel.email}");
      print("_api.homeModel.country ${_api.homeModel.country}");
      print("_api.homeModel.dob ${_api.homeModel.dob}");
      print("_api.homeModel.name ${_api.homeModel.name}");
      print("_api.homeModel.nationality ${_api.homeModel.nationality}");
      print("_api.homeModel.phoneNum ${_api.homeModel.phoneNum}");
      print("_api.homeModel.cover ${_api.homeModel.cover}");
      print("_api.homeModel.profile ${_api.homeModel.profile}");
      if (
        identifierModel!.backImage != "" &&
        identifierModel!.frontImage != ""&&
        identifierModel!.selfieImage != "" &&
        _api.homeModel.email != "" &&
        _api.homeModel.country != "" &&
        _api.homeModel.dob != "" &&
        _api.homeModel.name != "" &&
        _api.homeModel.nationality != "" &&
        _api.homeModel.phoneNum != "" &&
        _api.homeModel.cover != "" &&
        _api.homeModel.profile != ""
      ){
        _dataToBlockchain = toJson(_api.homeModel);
        
        Provider.of<HomeProvider>(context, listen: false).readyToSubmit = true;
        print("finish finish");
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error isAbleSubmitToBlockchain $e");
    }
    notifyListeners();
    return false;
  }

  void notify(){
    notifyListeners();
  }

  Map<String, dynamic> toJson(DashBoardModel homeModel){
    return {
      "backImage": identifierModel!.backImage,
      "frontImage": identifierModel!.frontImage,
      "selfieImage": identifierModel!.selfieImage,
      "email": homeModel.email,
      "country": homeModel.country,
      "dob": homeModel.dob,
      "name": homeModel.name,
      "nationality": homeModel.nationality,
      "phoneNum": homeModel.phoneNum,
      "cover": homeModel.cover,
      "profile": homeModel.profile
    };
  }
}