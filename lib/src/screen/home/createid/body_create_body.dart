import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';

class CraeteIDBody extends StatelessWidget {

  final List<dynamic>? docs;

  const CraeteIDBody({
    Key? key, 
    this.docs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexaCodeToColor(AppColors.primaryColor),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: hexaCodeToColor(AppColors.primaryColor),
        title: Consumer<DocumentProvider>(
          builder: (context, provider, widget){
            return  MyText(
              text: provider.title,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteHexaColor,
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
                    // Text(docs![index]['formController'].text),
                    MyInputField(
                      inputType: docs![index]['type'] == 'integer' ? TextInputType.number : TextInputType.text,
                      focusNode: docs![index]['focusNode'],
                      controller: docs![index]['formController'],
                      // hintText: docs![index]['key'],
                      onChanged: (String value){
                        
                      },
                      onSubmit: (String value) {

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