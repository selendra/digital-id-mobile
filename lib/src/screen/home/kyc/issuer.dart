import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';

class IssuerListForm extends StatelessWidget {

  final Function? createID;

  const IssuerListForm({Key? key, this.createID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: MyText(
          text: "Documents Type",
          color: AppColors.whiteColorHexa,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingSize),
        child: Column(
          children: [

            CustomButtonIcon(
              onPressed: () async {
                await createID!();
              },
              text: 'Certificate Grade 9',
              icon: const Icon(Iconsax.arrow_right_3),
              colorBtn: Colors.white.withOpacity(0.06),
              colorText: Colors.white,
            ),

            SizedBox(
              height: 2.h,
            ),
            CustomButtonIcon(
              onPressed: () async {
                await createID!();
              },
              text: 'Certificate Grade 12',
              icon: const Icon(Iconsax.arrow_right_3),
              colorBtn: Colors.white.withOpacity(0.06),
              colorText: Colors.white,
            ),
            
          ],
        ),
      ),
    );
  }
}