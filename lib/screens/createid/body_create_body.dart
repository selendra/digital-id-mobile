import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/my_input_c.dart';

class CraeteIDBody extends StatelessWidget {
  final TextEditingController? nationalIDController;
  final TextEditingController? givenNameController;
  final TextEditingController? familyNameControler;
  final TextEditingController? placeOfBirthController;

  const CraeteIDBody({
    Key? key, 
    this.nationalIDController,
    this.givenNameController,
    this.familyNameControler,
    this.placeOfBirthController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: MyText(
          text: "National ID",
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(paddingSize),
        child: Column(
          children: [
            _textfieldTemplate(),
          ],
        ),
      ),
    );
  }

  Widget _textfieldTemplate () {
    return Column(
      children: [
        MyInputField(
          controller: nationalIDController,
          hintText: "National ID",
          onSubmit: () {

          },
        ),

        const SizedBox(height: paddingSize),

        MyInputField(
          controller: nationalIDController,
          hintText: "Given Name",
          onSubmit: () {

          },
        ),

        const SizedBox(height: paddingSize),

        MyInputField(
          controller: familyNameControler,
          hintText: "Family Name",
          onSubmit: () {

          },
        ),

        const SizedBox(height: paddingSize),
        MyInputField(
          controller: placeOfBirthController,
          hintText: "Place Of Birth",
          onSubmit: () {

          },
        ),
      ],
    );
  }

}