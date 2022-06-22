// variable for our route names
import 'package:digital_id/screens/verify_key/verify_key.dart';
import 'package:flutter/material.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/screens/otp_verify/otp_verify_page.dart';
import 'package:digital_id/screens/registration/signup/signup.dart';
import 'package:digital_id/screens/setup_wallet/import_acc/import_acc.dart';

const String loginRoute = '/';
const String signUpRoute = '/signUp';
const String navbarRoute = 'navbar';
const String verifyRoute = 'verify';
const String setupRoute = 'setup';
const String createWalletRoute = 'createWallet';
const String verifyWaletRoute = 'verifyWallet';
const String importRoute = 'importAcc';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      // case navbarRoute:
      //   return MaterialPageRoute(builder: (_) => const Navbar());
      case verifyRoute:
        return MaterialPageRoute(builder: (_) => OTPVerifyPage());
      case setupRoute:
        return MaterialPageRoute(builder: (_) => const SetupPage());
      case createWalletRoute:
        return MaterialPageRoute(builder: (_) => const CreateWalletPage());
      case verifyWaletRoute:
        return MaterialPageRoute(builder: (_) => VerifyPassphrase());
      case importRoute:
        return MaterialPageRoute(builder: (_) => ImportAccount());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
