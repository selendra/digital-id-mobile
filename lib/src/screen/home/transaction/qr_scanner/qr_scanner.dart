import 'package:http/http.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet_apps/src/components/appbar_c.dart';
import 'package:web3dart/web3dart.dart';

class QrScanner extends StatefulWidget {
  // final List portList;
  // final WalletSDK sdk;
  // final Keyring keyring;

  // QrScanner({this.portList, this.sdk, this.keyring});

  @override
  State<StatefulWidget> createState() {
    return QrScannerState();
  }
}

class QrScannerState extends State<QrScanner> with SingleTickerProviderStateMixin{

  final GlobalKey qrKey = GlobalKey();

  String? barcode;

  static const String privateKey = 'a2fd51b96dc55aeb14b30d55a6b3121c7b9c599500c1beb92a389c3377adc86e';
  static const String rpcUrl = 'http://localhost:7545';

  final client = Web3Client(rpcUrl, Client());
  
  final ApiProvider _apiProvider = ApiProvider();

  late final Future<String> mnemonic;


  // Future? _onQrViewCreated(QRViewController controller) async {
  //   controller.resumeCamera();
  //   try {
  //     controller.scannedDataStream.listen((event) async {
  //       // dynamic data = await json.decode(event.code!);
  //       final data = jsonDecode(event.code!);
  //       // print("event value: ${data}");
  //       // print('${data.runtimeType} : $data');
  //       // print("${Map<String, dynamic>.from(data)}");
  //       final decode = Map<String, String>.from(data);
  //       print('${decode.runtimeType}');

  //       await controller.pauseCamera();

  //       // Navigator.pop(context, event.code);s

  //     });

  //   } catch (e) {
     
  //   }

  //   return controller;
  // }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeProvider>(context).isDark;
    return Scaffold(
      body: BodyScaffold(
        physic: const NeverScrollableScrollPhysics(),
        height: MediaQuery.of(context).size.height,
        bottom: 0,
        child: Column(
          children: [
            MyAppBar(
              title: "Scanning",
              color: isDarkTheme
                ? hexaCodeToColor(AppColors.darkBgd).withOpacity(0)
                : hexaCodeToColor(AppColors.whiteHexaColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: MobileScanner(
                fit: BoxFit.contain,
                // allowDuplicates: false,
                onDetect: (barcode, args) {
                  setState(() {
                    this.barcode = barcode.rawValue;
                    
                    final String? barcodeData = this.barcode;

                    Navigator.pop(context, barcodeData);

                    // if(decode["id"] == null) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       title: Text("Error"),
                    //       content: Text("Invalid QR Code"),
                    //       actions: [
                    //         FlatButton(
                    //           child: Text("OK"),
                    //           onPressed: () async{
                    //             // await client.signTransaction(
                    //             //   credentials, 
                    //             //   transaction
                    //             // )
                    //             // await client.signTransaction(
                    //             //   credentials,
                    //             //   Transaction(
                    //             //     to: EthereumAddress.fromHex('0xC914Bb2ba888e3367bcecEb5C2d99DF7C7423706'),
                    //             //     gasPrice: EtherAmount.inWei(BigInt.one),
                    //             //     maxGas: 100000,
                    //             //     value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
                    //             //   ),
                    //             // );

                    //             await client.dispose();

                    //             Navigator.pop(context);
                    //           },
                    //         )
                    //       ],
                    //     ),
                    //   );
                    // } 
                    // else{
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       title: Text("Error"),
                    //       content: Text("Valid QR Code"),
                    //       actions: [
                    //         FlatButton(
                    //           child: Text("OK"),
                    //           onPressed: () {

                    //             Navigator.pop(context);
                    //           },
                    //         )
                    //       ],
                    //     ),
                    //   );
                    // }
                  });
                },
              ),
              // child: QRView(
              //   key: qrKey,
              //   onQRViewCreated: (QRViewController qrView) async {
              //     await _onQrViewCreated(qrView);
              //   },
              //   overlay: QrScannerOverlayShape(
              //     borderRadius: 10,
              //     borderWidth: 10,
              //   ),
              // )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 50,
                        child: FittedBox(
                          child: Text(
                            barcode ?? 'Scan something!',
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
