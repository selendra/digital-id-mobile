import 'package:flutter_svg/svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';

class MyBottomSheetItem extends StatelessWidget {
  final String? subTitle;
  final String? icon;
  final void Function()? action;

  const MyBottomSheetItem(
      {@required this.subTitle, @required this.icon, @required this.action});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeProvider>(context).isDark;
    return GestureDetector(
        onTap: action,
        child: Column(
          children: [
            SvgPicture.asset(
              AppConfig.assetsPath+'$icon',
              width: 30,
              height: 30,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
            MyText(
              top: 6,
              text: subTitle,
              fontSize: 12,
              color:
                  isDarkTheme ? AppColors.whiteColorHexa : AppColors.textColor,
            )
          ],
        ));
  }
}

/* -------------------------Transaction Method--------------------------- */

class TrxOptionMethod {
  // ignore: avoid_void_async
  static void selectContact(
    BuildContext context,
    List<dynamic> listPortfolio,
  ) async {
    if (await Permission.contacts.request().isGranted) {
      final PhoneContact? _contact = await FlutterContactPicker.pickPhoneContact();
      // final Contact _contact = await ContactsService.openDeviceContactPicker();
      //Get Contact And Asign To Number Variable

      if (_contact != null) {
        // await _postRequest.getWalletFromContact(
        //   "+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)  }" // Replace 0 At The First Index To Empty
        // ).then((value) async {
        //   if(value['status_code'] == 200 && value.containsKey('wallet')){
        //     response = await Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => SubmitTrx(value['wallet'], false, listPortfolio))
        //     );
        //     if (response["status_code"] == 200) {
        //       resetDbdState(null, "portfolio");
        //       Navigator.pop(context);
        //     }
        //   } else {
        //     await dialog(
        //       context,
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[
        //           textAlignCenter(text: value['message']),
        //           Container(
        //             margin: EdgeInsets.only(top: 5.0),
        //             child: textAlignCenter(text: "Do you want to invite this number 0${_contact.phoneNumber.number.replaceFirst("0", "", 0)}?")
        //           )
        //         ],
        //       ),
        //       textMessage(),
        //       action: FlatButton(
        //         child: Text("Invite"),
        //         onPressed: () async {
        //           Navigator.pop(context); // Close Dialog Invite
        //           dialogLoading(context); // Process Loading
        //           var _response = await _postRequest.inviteFriend("+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)}");
        //           Navigator.pop(context); // Close Dialog Loading
        //           if (_response != null) {
        // await dialog(context, Text(_response['message'], textAlign: TextAlign.center,), Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor)));
        //           }
        //         },
        //       )
        //     );
        //   }
        // });
      }
    }
  }

  // ignore: avoid_void_async
  static void navigateFillAddress(
    BuildContext context,
    List<dynamic> portfolioList,
  ) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubmitTrx("", true, portfolioList)));
  }

  /* Scan QR Code */
  Future scanQR(
    BuildContext context,
    List<dynamic> portfolioList,
    bool pushReplacement,
  ) async {
    final data = await Navigator.push(context, Transition(child: QrScanner(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
    return data;
  }
}
