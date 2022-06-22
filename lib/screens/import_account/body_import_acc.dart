import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/custom_button.c.dart';
import 'package:digital_id/components/my_input_c.dart';
import 'package:digital_id/components/seeds_c.dart';
import 'package:digital_id/models/import_acc_m.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ImportAccBody extends StatelessWidget {
  final bool? enable;
  final String? reImport;
  final ImportAccModel? importAccModel;
  final Function? onChanged;
  final Function? onSubmit;
  final Function? clearInput;
  final Function? submit;

  ImportAccBody({
    this.importAccModel,
    this.onChanged,
    this.onSubmit,
    this.clearInput,
    this.enable,
    this.reImport,
    this.submit,
  });

  final EdgeInsetsGeometry padding = EdgeInsets.only(left: paddingSize, right: paddingSize);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(paddingSize),
        child: Form(
          key: importAccModel!.formKey,
          child: Column(
            children: [

              SeedContents(
                title: 'Restore with seed', 
                subTitle: 'Please add your 12 words seed below to restore your wallet.'
              ),

              MySeedField(
                pLeft: 0, pRight: 0,
                pTop: 20,
                pBottom: 16.0,
                hintText: "Add your 12 keywords",
                textInputFormatter: [
                  LengthLimitingTextInputFormatter(
                    TextField.noMaxLength,
                  )
                ],
                controller: importAccModel!.mnemonicCon,
                focusNode: importAccModel!.mnemonicNode,
                maxLine: 7,
                onChanged: onChanged,
                //inputAction: TextInputAction.done,
                onSubmit: onSubmit,
              ),

              Expanded(child: Container()),
              MyGradientButton(
                textButton: "Continue",
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                action: onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
