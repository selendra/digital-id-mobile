import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wallet_apps/src/provider/api_provider.dart';

import '../../../../index.dart';

class AssetInfoC {
  bool transferFrom = false;

  Widget appBar(BuildContext context, Color color, String trailingText,
      Widget title, void Function() leadingFunction) {
    return Container(
      height: 65.0,
      width: MediaQuery.of(context).size.width,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.only(left: 30),
                iconSize: 40.0,
                icon: const Icon(
                  LineAwesomeIcons.arrow_left,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: leadingFunction,
              ),
              title
            ],
          ),
          MyText(
            text: trailingText,
            right: 30,
          ),
        ],
      ),
    );
  }

  void showRecieved(BuildContext mycontext, GetWalletMethod _method, {String? symbol, org, SmartContractModel? scModel}) {

    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: mycontext,
      builder: (BuildContext context) {

        final _keyQrShare = GlobalKey();
        final _globalKey = GlobalKey<ScaffoldState>();
        final isDarkTheme = Provider.of<ThemeProvider>(mycontext).isDark;
        final _api = Provider.of<ApiProvider>(context);

        return Scaffold(
          key: _globalKey,
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 27.0),
            color: isDarkTheme ? Color(AppUtils.convertHexaColor(AppColors.darkBgd)) : Color(AppUtils.convertHexaColor("#F5F5F5")),
            child: symbol != null

            ? Consumer<ContractProvider>(
                builder: (context, value, child) {
                  // final api = Provider.of<ApiProvider>(context, listen: false).btcAdd;
                  // String wallet = '';
                  // if (symbol == 'BTC') {
                  //   wallet = api;
                  // } else if (symbol == 'BNB' || org == 'BEP-20') {
                  //   wallet = value.ethAdd;
                  // } else {
                  //   wallet = _api.getKeyring.current.address!;
                  // }
                  return ReceiveWalletBody(
                    // wallet: symbol == 'BNB' || org == 'BEP-20'
                    //     ? value.ethAdd
                    //     : ApiProvider.keyring.current.address,
                  );
                },
              )
            : Consumer<ApiProvider>(
                builder: (context, value, child) {
                  return ReceiveWalletBody();
                },
              )
            ),
        );
      },
    );
  }
}
