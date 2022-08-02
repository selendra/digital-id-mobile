import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/models/kyc_content_m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/kyc/body_setup_kyc.dart';

class SetUpKYC extends StatefulWidget {

  final bool? isSelendraID;

  SetUpKYC({Key? key, this.isSelendraID}) : super(key: key);

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
    Provider.of<DocumentProvider>(context, listen: false).initDocs();
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