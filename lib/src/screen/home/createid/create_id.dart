


import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/createid/body_create_body.dart';

class CreateID extends StatefulWidget {

  final List<dynamic>? docs;

  CreateID({Key? key, this.docs}) : super(key: key);

  @override
  State<CreateID> createState() => _CreateIDState();
}

class _CreateIDState extends State<CreateID> {
  
  Future<void> submitKYC() async {
    bool isEmpty = false;
    for(int i = 0; i < widget.docs!.length; i++){
      if (widget.docs![i]['formController'].text == ""){
        isEmpty = true;
        break;
      }
    }

    if (isEmpty){
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return CraeteIDBody(
      docs: widget.docs,
    );
  }
}