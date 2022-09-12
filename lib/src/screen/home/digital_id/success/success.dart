import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wallet_apps/src/screen/home/digital_id/success/body_success.dart';

class SuccessSubmit extends StatefulWidget {
  const SuccessSubmit({Key? key}) : super(key: key);

  @override
  State<SuccessSubmit> createState() => _SuccessSubmitState();
}

class _SuccessSubmitState extends State<SuccessSubmit> {
  @override
  Widget build(BuildContext context) {
    return SuccessSubmitBody();
  }
}