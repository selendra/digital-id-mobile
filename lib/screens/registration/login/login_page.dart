import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/alert_dialog_c.dart';
import 'package:digital_id/core/backend.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/core/decode_token.dart';
import 'package:digital_id/core/graphql/schema.dart';
import 'package:digital_id/models/digital_id_m.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/provider/digital_id_p.dart';
import 'package:digital_id/provider/graphql_p.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/provider/registration_p.dart';
import 'package:digital_id/screens/otp_verify/otp_verify_page.dart';
import 'package:digital_id/services/storage.dart';

import '../../../shared/bg_shared.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  bool? isChecked = false;
  bool? checkLogin = true;
  ApiProvider? _api;
  
  final formKey = GlobalKey<FormState>();

  void handleRememberMe(bool? value) async {
    setState(() {
      isChecked = value;
    });
  }

  void validator() {
    final form = formKey.currentState!;

    if (form.validate()) {
      Navigator.pushReplacementNamed(context, verifyRoute);
    }
  }

  void isLogin() async {

    await StorageServices.fetchData(DbKey.login).then((value) {
      print("Login $value");
      if (value != null) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPage()), (route) => false);
      // if (value != null) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Identifier(title: "",)), (route) => false);
    });

    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ImportAccount()), (route) => false);
    // await Future.delayed(Duration(seconds: 1), (){});
    // Provider.of<ApiProvider>(context, listen: false).initApi(context: context);
    setState(() {
      checkLogin = false;
    });
    // await StorageServices.fetchData("session").then((value) async {
    //   print("Session $value");
    //   if (value != null){

    //     print("Start navigate");
    //     await Navigator.push(
    //       context, 
    //       MaterialPageRoute(builder: (context) => WalletConnectPage())
    //     );
    //   }
    // });
  }

  Future<void> submitLogin() async {

    
    Backend().login("bytesharedmin@gmail.com", "adminbyteshare5556").then((value) async {
      Map<String, dynamic> _map = await json.decode(value.body);
      print("_map['access_token'] $_map");
      
      //Decode access_token
      JwtDecode.tryParseJwt(_map['access_token'], context);
      GraphQLConfiguration.setToken(_map['access_token']);
    });
    // MyDialog().dialogLoading(context);
    // try {

    //   await _api!.loginSELNetwork(email: emailInputController.text, password: passwordInputController.text).then((value) async {

    //     if (value['status'] == true) {
          
    //       Provider.of<RegistrationProvider>(context, listen: false).email = emailInputController.text;
    //       Provider.of<RegistrationProvider>(context, listen: false).password = passwordInputController.text;

    //       Map<String, dynamic> result = await _api!.query(email: emailInputController.text);

    //       Provider.of<HomeProvider>(context, listen: false).setWallet = result['accountId'];//_api!.accountM.address!;
    //       _api!.accountM.address = result['accountId'];//_api!.accountM.address!;
    //       print(_api!.accountM.address);
    //       Provider.of<HomeProvider>(context, listen: false).homeModel.email = emailInputController.text;//_api!.accountM.address!;
    //       await _api!.encryptData(context: context);
    //       await StorageServices.storeData(true, DbKey.login);

    //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPage()), (route) => false);
 
    //     } else {
    //       Navigator.pop(context);
    //       await MyDialog().customDialog(context, "Message", "${value['message']}");
    //     }
    //   });

    // } catch (e) {
    //   debugPrint("Error submitSignUp $e");
    //   // Navigator.pop(context);
    // }
  }

  @override
  void initState() {
    // initialize();
    isLogin();
    _api = Provider.of<ApiProvider>(context, listen: false);
    // emailInputController.text = "condaveat@gmail.com";
    // passwordInputController.text = "123456";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return checkLogin == false 
    // ? TestGlasUI(
    //   body: 
     ? LoginPageBody(
        emailInputController: emailInputController,
        passwordInputController: passwordInputController,
        handleRememberMe: handleRememberMe,
        isChecked: isChecked,
        formKey: formKey,
        validator: validator,
        submitLogin: submitLogin
      )
    // ) 
    : const Scaffold(body: Center(
      child: CircularProgressIndicator(),
    ),);
  }
}
