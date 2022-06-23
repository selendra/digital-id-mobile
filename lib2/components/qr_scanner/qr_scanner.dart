import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/theme/theme.dart';

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

class QrScannerState extends State<QrScanner> {

  final GlobalKey qrKey = GlobalKey();

  Future? _onQrViewCreated(QRViewController controller) async {
    try {
      controller.scannedDataStream.listen((event) async {
        controller.dispose();

        Navigator.pop(context, event.code);

      });

    } catch (e) {
     
    }

    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: (QRViewController qrView) async {
                  await _onQrViewCreated(qrView);
                },
                overlay: QrScannerOverlayShape(
                  borderRadius: 10,
                  borderWidth: 10,
                ),
              )
            ),
          ],
        )
      ),
    );
  }
}
