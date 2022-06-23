import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/alert_dialog_c.dart';
import 'package:digital_id/components/walletConnect_c.dart';
import 'package:digital_id/core/backend.dart';
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/provider/registration_p.dart';
import 'package:digital_id/screens/otp_verify/otp_verify_page.dart';
import 'package:digital_id/screens/wallet_connect/body_walletconnect_page.dart';
import 'package:digital_id/services/storage.dart';
import 'package:wallet_connect/wallet_connect.dart';

class WalletConnectPage extends StatefulWidget {
  const WalletConnectPage({Key? key}) : super(key: key);

  @override
  _WalletConnectPageState createState() => _WalletConnectPageState();
}

class _WalletConnectPageState extends State<WalletConnectPage> {


  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  bool? isChecked = false;
  bool? checkLogin = true;

  WalletConnectComponent? _wConnectC;
  
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
    // await StorageServices.fetchData(DbKey.login).then((value) {
    //   if (value != null) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Navbar()), (route) => false);
    // });

    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ImportAccount()), (route) => false);
    // await Future.delayed(Duration(seconds: 1), (){});
    // Provider.of<ApiProvider>(context, listen: false).initApi(context: context);
    setState(() {
      checkLogin = false;
    });
  }

  Future<void> submitLogin() async {

    MyDialog().dialogLoading(context);
    print("submitLogin");
    try {
      // await Future.delayed(Duration(seconds: 1), (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => SetupPage()));
      // });

      await Provider.of<ApiProvider>(context, listen: false).loginSELNetwork(email: emailInputController.text, password: passwordInputController.text).then((value) async {
      
        // Close Dialog
        Navigator.pop(context);

        if (value['status'] == true) {
          
          Provider.of<RegistrationProvider>(context, listen: false).email = emailInputController.text;
          Provider.of<RegistrationProvider>(context, listen: false).password = passwordInputController.text;

          await Backend().getOtp(emailInputController.text).then((value) async {
            if (value.statusCode == 201){
              await MyDialog().customDialog(context, "Message", "We sent you 6 digit OTP code.\nPlease check your email.");
            }
          });

          Navigator.push(context, MaterialPageRoute(builder: (context) => OTPVerifyPage())); 
          // Navigator.push(context, MaterialPageRoute(builder: (context) => SetupPage())); 
        } else {
          await MyDialog().customDialog(context, "Message", "${value['message']}");
        }
      });

    } catch (e) {
      print("Error submitSignUp $e");
      // Navigator.pop(context);
    }
  }


  @override
  void initState() {
    StorageServices.fetchData("session").then((value) {
      print("Session $value");
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WalletConnectBody(
      emailInputController: emailInputController,
      passwordInputController: passwordInputController,
      handleRememberMe: handleRememberMe,
      isChecked: isChecked,
      formKey: formKey,
      validator: validator,
      submitLogin: submitLogin,

    );
  }
}
