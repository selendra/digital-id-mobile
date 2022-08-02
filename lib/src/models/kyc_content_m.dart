import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/kyc/issuer.dart';
class KYCDocs {

  List<CustomButtonCard>? lsPopularDocs = [];
  List<CustomButtonCard>? lsIssuer = [];

  List<Map<String, dynamic>> data = [];

  List<Map<String, dynamic>> selendra = [];
  List<Map<String, dynamic>> pending = [];
  List<Map<String, dynamic>> approve = [];

}