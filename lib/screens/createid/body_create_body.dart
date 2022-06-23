import 'package:digital_id/all_export.dart';
import 'package:digital_id/components/components_c.dart';
import 'package:digital_id/components/my_input_c.dart';
import 'package:digital_id/provider/documents_p.dart';
import 'package:provider/provider.dart';

class CraeteIDBody extends StatelessWidget {

  final List<dynamic>? docs;

  const CraeteIDBody({
    Key? key, 
    this.docs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Consumer<DocumentProvider>(
          builder: (context, provider, widget){
            return  MyText(
              text: provider.title,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
            );
          }
        ),
      ),
      body: Column(
        children: [
          
          Expanded(
            child: ListView.builder(
              itemCount: docs!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Column(
                  children: [

                    MyInputField(
                      inputType: docs![index]['type'] == 'integer' ? TextInputType.number : TextInputType.text,
                                  
                      controller: docs![index]['formController'],
                      hintText: docs![index]['key'],
                      
                      onSubmit: () {

                      },
                    ),
                    const SizedBox(height: paddingSize),
                  ]
                );
              },
            ),
          ),

          MyGradientButton(
            edgeMargin: EdgeInsets.only(top: paddingSize, left: paddingSize, right: paddingSize),
            textButton: "Upload KYC",
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            action: () async {
              // await submitAsset!();
            }
          ),
          // _textfieldTemplate(),
        ],
      ),
    );
  }

  // Widget _textfieldTemplate () {
  //   return Column(
  //     children: [
  //       MyInputField(
  //         controller: nationalIDController,
  //         hintText: "National ID",
  //         onSubmit: () {

  //         },
  //       ),

  //       const SizedBox(height: paddingSize),

  //       MyInputField(
  //         controller: nationalIDController,
  //         hintText: "Given Name",
  //         onSubmit: () {

  //         },
  //       ),

  //       const SizedBox(height: paddingSize),

  //       MyInputField(
  //         controller: familyNameControler,
  //         hintText: "Family Name",
  //         onSubmit: () {

  //         },
  //       ),

  //       const SizedBox(height: paddingSize),
  //       MyInputField(
  //         controller: placeOfBirthController,
  //         hintText: "Place Of Birth",
  //         onSubmit: () {

  //         },
  //       ),
  //     ],
  //   );
  // }

}