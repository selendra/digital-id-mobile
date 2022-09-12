import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wallet_apps/index.dart';

class HomeProvider with ChangeNotifier{

  DashBoardModel homeModel = DashBoardModel();
  IO.Socket? socket;

  bool successSubmitToBlockchain = false;
  bool readyToSubmit = false;

  bool isConnectedMPTC = false;

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
  // 'http://137.184.224.174:4000'
  Future<void> connectWS(String id, { required BuildContext? context}) async{ 
    print("connectWS");
    try{

      socket = IO.io(
        'https://auth-student.selendra.org/', 
        IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .setExtraHeaders({'authorization': 'dummytoken'}) // optional
        .build()
      );

      socket!.onConnect((data) {
        print('connected');

        Map<String, dynamic> data = {
          "id": id,
          "email": Provider.of<HomeProvider>(context!, listen: false).homeModel.email,
          "pubKey": Provider.of<HomeProvider>(context, listen: false).homeModel.wallet
        };
        socket!.emit("/auth/qr-scan", data);

        isConnectedMPTC = true;
        
        // MotionToast.success(
        //   title:  Text("Success"),
        //   description:  Text("Scan had connected"),
        //   layoutOrientation: ORIENTATION.ltr,
        //   animationType: ANIMATION.fromLeft, width:  300,
        //   position: MOTION_TOAST_POSITION.top,
        // ).show(context);

      });
      socket!.onConnectError((data) {
        print("onConnectError $data");
      });
      socket!.onError((data) {
        print("onError $data");
      });
      socket!.connect();

    } catch (e) {
      print("Error connectWS $e");
    }
  }

  void submitEdit(DashBoardModel model){

    homeModel.email = model.emailController.text;
    homeModel.country = model.country;
    homeModel.dob = model.dob;
    homeModel.name = model.nameController.text;
    homeModel.nationality = model.nationalityController.text;
    homeModel.phoneNum = model.phoneNumController.text;
    // homeModel.cover = model.cover;  
    homeModel.profile = model.profile;
    notifyListeners();
  }

  void notify(){
    notifyListeners();
  }
}