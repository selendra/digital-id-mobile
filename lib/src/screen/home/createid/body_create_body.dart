import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/digital_id/front_side/front_side.dart';
import 'package:wallet_apps/src/utils/string_extension.dart';

class CraeteIDBody extends StatelessWidget {

  final List<dynamic>? docs;

  const CraeteIDBody({
    Key? key, 
    this.docs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Consumer<DocumentProvider>(
          builder: (context, provider, widget){
            return  MyText(
              text: provider.title,
              fontWeight: FontWeight.w600,
              color: AppColors.newText,
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
                      hintText: camelToSentence(docs![index]['key']),
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

          MyFlatButton(
            edgeMargin: EdgeInsets.all(paddingSize),
            textButton: "Upload KYC",
            buttonColor: AppColors.newPrimary, 
            action: () async {
              Navigator.push(context, Transition(child: FrontSide(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
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