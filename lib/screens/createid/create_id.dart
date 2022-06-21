

import 'package:digital_id/all_export.dart';
import 'package:digital_id/screens/createid/body_create_body.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';


class CreateID extends StatefulWidget {
  const CreateID({Key? key}) : super(key: key);

  @override
  State<CreateID> createState() => _CreateIDState();
}

class _CreateIDState extends State<CreateID> {

  final TextEditingController _nationalIDController = TextEditingController();
  final TextEditingController _givenNameController = TextEditingController();
  final TextEditingController _familyNameControler = TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return CraeteIDBody(
      nationalIDController: _nationalIDController,
      givenNameController: _givenNameController,
      familyNameControler: _familyNameControler,
      placeOfBirthController: _placeOfBirthController,
    );
  }
}