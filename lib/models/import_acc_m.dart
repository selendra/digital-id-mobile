import 'package:digital_id/all_export.dart';

class ImportAccModel {
  
  TextEditingController mnemonicCon = TextEditingController();
  TextEditingController json = TextEditingController();

  TextEditingController pwCon = TextEditingController();

  final formKey = GlobalKey<FormState>();

  FocusNode mnemonicNode = FocusNode();

  FocusNode pwNode = FocusNode();
}