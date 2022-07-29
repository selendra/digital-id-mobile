import 'dart:ui';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: MyText(
          text: "Digital Scan",
          fontSize: 18,
          color: AppColors.newText,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BodyScaffold(
        physic: const NeverScrollableScrollPhysics(),
        height: MediaQuery.of(context).size.height,
        bottom: 0,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  MobileScanner(
                    // fit: BoxFit.contain,
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

                  // BackdropFilter(
                  //   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  //   child: Center(
                  //     child: Card(
                  //       elevation: 10,
                  //       color: Colors.black.withOpacity(0.5),
                  //       child: const SizedBox(
                  //         width: 300,
                  //         height: 200,
                  //         child: Center(
                  //           child: Text(
                  //             'Some Text',
                  //             style: TextStyle(fontSize: 30, color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
