

import 'package:digital_id/all_export.dart';
import 'package:digital_id/screens/createid/body_create_body.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

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