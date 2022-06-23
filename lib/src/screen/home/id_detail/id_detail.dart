
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/id_detail/body_id_detail.dart';

class IdDetail extends StatefulWidget {
  const IdDetail({Key? key}) : super(key: key);

  @override
  State<IdDetail> createState() => _IdDetailState();
}

class _IdDetailState extends State<IdDetail> {
  @override
  Widget build(BuildContext context) {
    return IdDetailBody();
    
  }
}