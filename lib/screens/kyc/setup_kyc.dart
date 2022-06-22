import 'package:digital_id/all_export.dart';
import 'package:digital_id/models/kyc_content_m.dart';
import 'package:digital_id/screens/kyc/body_setup_kyc.dart';

class SetUpKYC extends StatefulWidget {
  const SetUpKYC({Key? key}) : super(key: key);

  @override
  State<SetUpKYC> createState() => _SetUpKYCState();
}

class _SetUpKYCState extends State<SetUpKYC> {

  bool _isShowMorePopularDocs = false;
  bool _isShowMoreIssuer = false;

  void _onShowMorePopularDocs() {
    setState(() {
      _isShowMorePopularDocs = !_isShowMorePopularDocs;
    });
  }

  void _onShowMoreIssuer() {
    setState(() {
      _isShowMoreIssuer = !_isShowMoreIssuer;
    });
  }
  @override
  void initState() {
    super.initState();
    KYCDocs.initContext(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SetUpKYCBody(
      isShowMorePopularDocs: _isShowMorePopularDocs,
      isShowMoreIssuer: _isShowMoreIssuer,
      onShowMorePopularDocs: _onShowMorePopularDocs,
      onShowMoreIssuer: _onShowMoreIssuer,
    );
  }
}