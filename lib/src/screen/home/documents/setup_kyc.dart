import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/api/api.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/documents/body_setup_kyc.dart';
import 'package:http/http.dart' as http;

class SetUpKYC extends StatefulWidget {

  final bool? isSelendraID;

  SetUpKYC({Key? key, this.isSelendraID}) : super(key: key);

  @override
  State<SetUpKYC> createState() => _SetUpKYCState();
}

class _SetUpKYCState extends State<SetUpKYC> {

  bool _isShowMorePopularDocs = false;
  bool _isShowMoreIssuer = false;

  DocumentProvider? _docsProvider;

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

  // void getData() async {
  //   try {

  //     print("getData");
  //     http.Response response = await http.get(Uri.parse(Api.getAllOrgApi));
  //     print("response ${json.decode(response.body)['organizations'][0]}");
  //   } catch (e) {
  //     print("Error getData $e");
  //   }
  // }

  // void checkNoSelendraDocs() async {
  //   _docsProvider = Provider.of<DocumentProvider>(context, listen: false);
  //   if (widget.isSelendraID!){
  //     // [0].lsOrg!
  //     print("_docsProvider!.lsDocs![0].lsOrg! ${_docsProvider!.lsDocs!}");

  //     // _docsProvider!.title = _docsProvider!.lsDocs![0].docsList![j]

  //     // Provider.of<DocumentProvider>(context, listen: false).title = provider.lsDocs![index].docsList![j]['name'];
  //     // MyBottomSheet().createDocumentBottomSheet(context, _docsProvider!.lsDocs![0].lsOrg![j].owner);
  //     // Provider.of<DocumentProvider>(context, listen: false).initIssuer();
  //   }
  // }

  @override
  void initState() {
    // checkNoSelendraDocs();
    Provider.of<DocumentProvider>(context, listen: false).initIssuer();
    super.initState();
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