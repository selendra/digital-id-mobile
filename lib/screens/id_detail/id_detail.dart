import 'package:digital_id/all_export.dart';
import 'package:digital_id/screens/id_detail/body_id_detail.dart';

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