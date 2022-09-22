import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/dropdown_custom_c.dart';
import 'package:wallet_apps/src/models/documents/schemas_m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/utils/string_extension.dart';

class CreateIDBody extends StatelessWidget {

  // final List<dynamic>? provider.lsIssuerProp;
  final int? initValue;
  final Function? resetField;

  final Function? pickImage;
  final Function(int?)? onChanged;
  final Function? mintCredential;

  const CreateIDBody({
    Key? key, 
    // this.provider.lsIssuerProp,
    this.initValue,
    this.resetField,
    this.pickImage,
    this.onChanged,
    this.mintCredential
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
        actions: [
          Container(
            height: 50,
            width: 100,
            child: Consumer<DocumentProvider>(
              builder: (context, provider, child) {
                return DropDown(
                  isValue: true,
                  // assetInfo: provider.assetInfo,
                  listContract: SchemasModel.dropDownValue(provider.lsSchmDocs!),
                  initialValue: initValue.toString(),
                  onChanged: (String? value){
                    print("value $value");
                    onChanged!(int.parse(value!));
                  },
                );
                // Container(
                //   child: Text(provider.lsSchmDocs![1].details!['title'], style: TextStyle(color: Colors.red),),
                // );
              },
            ),
          )
        ],
      ),
      body: Consumer<DocumentProvider>(
        builder: (context, provider, widget) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                // Consumer<DocumentProvider>(
                //   builder: (context, value, child) {
                //   return ElevatedButton(
                //     onPressed: (){
                //       resetField!();
                //     }, 
                //     child: MyText(text: "Click",)
                //   );
                // }),
                    
                for (int i = 0; i < provider.lsIssuerProp!.length; i++)
                if ( provider.lsIssuerProp![i]['widget'].containsKey("image") )
                List.from(provider.lsIssuerProp![i]['widget']['image']).isEmpty ? InkWell(
                  onTap: () async {
                    await pickImage!(i);
                    // print(provider.lsIssuerProp![i]['widget']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromARGB(255, 195, 195, 195),
                    ),
                    margin: EdgeInsets.all(paddingSize),
                    width: MediaQuery.of(context).size.width,
                    height: 20.w,
                    child: Center(
                      child: Text("${provider.lsIssuerProp![i]['widget']['value']['description']}") 
                    ),
                  ),
                )
                : Container(height: 20.h, width: 20.w, child: Center(child: Image.file(File(provider.lsIssuerProp![i]['widget']['image'][0])))),
                
                
                Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView.builder(
                    itemCount: provider.lsIssuerProp!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                    
                          // Text(provider.lsIssuerProp![index]['formController'].text),
                          if (provider.lsIssuerProp![index]['widget'].containsKey('formController')) MyInputField(
                            inputType: (provider.lsIssuerProp![index]['type'] == 'integer' || provider.lsIssuerProp![index]['type'] == 'number') ? TextInputType.number : TextInputType.text,
                            focusNode: provider.lsIssuerProp![index]['widget']['focusNode'],
                            controller: provider.lsIssuerProp![index]['widget']['formController'],
                            hintText: (provider.lsIssuerProp![index]['type'] == 'number') ? 'Ex: 19990312' : camelToSentence(provider.lsIssuerProp![index]['key']),
                            enableInput: provider.lsIssuerProp![index]['editable'],
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
                  textButton: "Submit Document",
                  buttonColor: AppColors.newPrimary, 
                  action: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => Passcode(label: PassCodeLabel.fromMint))).then((value) async {
                      print("formBackUp $value");
                      // await disableScreenShot!();
                      if (value != null) await mintCredential!(value);
                    });
                    
                    // Navigator.push(context, Transition(child: FrontSide(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
                    // await submitAsset!();
                  }
                ),
                // _textfieldTemplate(),
              ],
            ),
          );
        }
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