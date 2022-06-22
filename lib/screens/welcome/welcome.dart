import 'package:digital_id/all_export.dart';
import 'package:digital_id/screens/welcome/body_welcome.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<Welcome> {
  
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  bool? status;
  int? currentVersion;

  //var snackBar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      key: globalKey,
      body: WelcomeBody(),
    );
  }
}
