import 'package:wallet_apps/index.dart';

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