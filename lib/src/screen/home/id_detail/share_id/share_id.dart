import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/id_detail/share_id/body_share_id.dart';

class ShareID extends StatefulWidget {
  const ShareID({Key? key}) : super(key: key);

  @override
  State<ShareID> createState() => _ShareIDState();
}

class _ShareIDState extends State<ShareID> {

  GlobalKey _keyQrShare = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ShareIDBody(
      keyQrShare: _keyQrShare,
    );
  }
}