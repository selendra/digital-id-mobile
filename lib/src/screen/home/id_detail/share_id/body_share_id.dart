

import 'dart:ffi';

import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/dropdown_custom_c.dart';
import 'package:wallet_apps/src/screen/home/receive_wallet/appbar_wallet.dart';

class ShareIDBody extends StatelessWidget {
  
  final GlobalKey? keyQrShare;

  const ShareIDBody({
    Key? key,
    this.keyQrShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexaCodeToColor(AppColors.primaryColor),
      appBar: AppBar(
        backgroundColor: hexaCodeToColor(AppColors.primaryColor),
        elevation: 0,
        title: Text('Share ID'),
      ),
      body: Column(
        children: [
          _qrCode(context),
        ],
      ),
    );
  }

  Widget _qrCode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        
        RepaintBoundary(
          key: keyQrShare,
          child: Padding(
            padding: const EdgeInsets.all(paddingSize),
            child: Container(
              padding: const EdgeInsets.all(paddingSize),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                // boxShadow: [shadow(context)],
                color: Colors.white.withOpacity(0.06)
              ),
              child: Column(
                children: [
                  
                  MyText(
                    bottom: 2.5.h,
                    text: "Scan the QR code to display information",
                    fontSize: 16,
                    color: AppColors.whiteColorHexa
                  ),

                  qrCodeGenerator(
                    "",
                    "",
                    keyQrShare!,
                  ),

                  

                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(top: paddingSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MyGradientButton(
                            // edgeMargin: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 16),
                            textButton: "Share",
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            action: () {
                            },
                          ),
                        ),

                        SizedBox(width: paddingSize),
                        
                        Expanded(child: getDropDown(context)),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        
      ],
    );
  }

  Widget getDropDown(BuildContext context) {
    return Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: CustDropDown(
                items: [
                  CustDropdownMenuItem(
                    value: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Iconsax.global,
                          color: Colors.black,
                        ),
                        Text("Public"),
                      ],
                    ),
                  ),
                  CustDropdownMenuItem(
                    value: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Iconsax.lock,
                          color: Colors.black,
                        ),
                        Text("Private"),
                      ],
                    ),
                  )
                ],
                hintText: "Access",
                borderRadius: 8,
                onChanged: (val) {
                  print(val);
                },
              ),
      ),
    );
  }
}