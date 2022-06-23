import 'package:digital_id/provider/documents_p.dart';
import 'package:digital_id/screens/createid/create_id.dart';
import 'package:digital_id/screens/id_detail/id_detail.dart';
import 'package:digital_id/screens/kyc/setup_kyc.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:digital_id/all_export.dart';
import 'package:provider/provider.dart';
import 'package:digital_id/components/walletConnect_c.dart';
import 'package:digital_id/provider/api_provider.dart';
import 'package:digital_id/provider/graphql_p.dart';
import 'package:digital_id/provider/home_p.dart';
import 'package:digital_id/provider/digital_id_p.dart';
import 'package:digital_id/provider/registration_p.dart';

import 'screens/digital_id/lading.dart';
import 'shared/bg_shared.dart';

void main() {
  // FlutterNativeSplash.removeAfter(initialization);
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DigitalIDProvider>(
          create: (context) => DigitalIDProvider(),
        ),
        ChangeNotifierProvider<ApiProvider>(
          create: (context) => ApiProvider(),
        ),
        ChangeNotifierProvider<RegistrationProvider>(
          create: (context) => RegistrationProvider(),
        ),
        ChangeNotifierProvider<WalletConnectComponent>(
          create: (context) => WalletConnectComponent(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<GraphQLConfiguration>(
          create: (context) => GraphQLConfiguration(),
        ),
        ChangeNotifierProvider<DocumentProvider>(
          create: (context) => DocumentProvider(),
        ),
      ],
      child: const MyApp()
    )
  );
}

void initialization(BuildContext context) async {
  // This is where you can initialize the resources needed by your app while
  // the splash screen is displayed.
}
class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  initState(){
    initApiProvider();

    Provider.of<DocumentProvider>(context, listen: false).initJson();

    WalletConnectComponent _wConnectC = WalletConnectComponent();
    _wConnectC.setBuildContext = context;
    super.initState();
  }
  
  initApiProvider() async {
    print("initApiProvider");
    try {

      ApiProvider _apiProvider = Provider.of<ApiProvider>(context, listen: false);

      // await Provider.of<ApiProvider>(context, listen: false).addAcc(context: context, usrName: _registration.usrName ?? '', password: "1234", seed: _seed).then((value) async {
      //   await encryptData(context: context, seed: _seed);
      // });
      
      await _apiProvider.initApi(context: context).then((value) async {
        print("_apiProvider.getKeyring.keyPairs.isNotEmpty ${_apiProvider.getKeyring.keyPairs.isNotEmpty}");
        
        // await _apiProvider.query(email: "vayime4593@dmosoft.com").then((value) async {

        //   Provider.of<HomeProvider>(context, listen: false).setWallet = value['accountId'];
        //   _apiProvider.accountM.address = value['accountId'];
        //   await _apiProvider.queryByAddr(addr: value['accountId']);
        // });
        // if (_apiProvider.getKeyring.keyPairs.isNotEmpty) {
        //   await _apiProvider.getAddressIcon();

        //   await _apiProvider.getCurrentAccount(funcName: "keyring").then((value) {
        //     Provider.of<HomeProvider>(context, listen: false).setWallet = _apiProvider.accountM.address!;
        //   });
        // }
        // await Provider.of<ApiProvider>(context, listen: false).getCurrentAccount();
      });
    } catch (e){
      print("Error initApiProvider $e");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student ID',
      theme: ThemeData(
        fontFamily: "Quicksand",
        scaffoldBackgroundColor: HexColor("#F3F3F3"),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      home: Home(),
      //LoginPage(),//CreateWalletPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: loginRoute,
    );
  }
}
