import 'package:flutter_screenshot_switcher/flutter_screenshot_switcher.dart';
import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/appbar_c.dart';
import 'package:wallet_apps/src/screen/main/mnemonic/confirm_mnemonic.dart';

class CreateMnemonic extends StatefulWidget {
  final String? passPhrase;
  final List passPhraseList;
  const CreateMnemonic(this.passPhrase, this.passPhraseList);

  @override
  _CreateMnemonicState createState() => _CreateMnemonicState();
}

class _CreateMnemonicState extends State<CreateMnemonic> {
  @override
  void initState() {
    disableScreenShot();
    super.initState();
  }

  Future<void> disableScreenShot() async {
    try {
      await FlutterScreenshotSwitcher.disableScreenshots();
    } catch (e) {}
  }

  Future<void> enableScreenShot() async {
    try {
      await FlutterScreenshotSwitcher.enableScreenshots().then((value) {});
    } catch (e) {}

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeProvider>(context).isDark;
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            MyAppBar(
              color: isDarkTheme
                ? hexaCodeToColor(AppColors.darkCard)
                : hexaCodeToColor(AppColors.whiteHexaColor),
              title: AppString.createAccTitle,
              onPressed: enableScreenShot,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [

                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: AppString.backupPassphrase,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme
                        ? AppColors.whiteColorHexa
                        : AppColors.textColor,
                      bottom: 12,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      textAlign: TextAlign.left,
                      text: AppString.keepMnemonic,
                      fontWeight: FontWeight.w500,
                      color: isDarkTheme
                        ? AppColors.whiteColorHexa
                        : AppColors.textColor,
                      bottom: 12,
                    ),
                  ),

                  // Display Mnemonic
                  if (widget.passPhrase == null)
                    CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation(
                        hexaCodeToColor(AppColors.secondary),
                      ),
                    )
                  else
                    Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: hexaCodeToColor(AppColors.darkSecondaryText).withOpacity(0.3),
                          width: 1
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: isDarkTheme
                        ? hexaCodeToColor(AppColors.darkCard)
                        : hexaCodeToColor(AppColors.whiteHexaColor),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.passPhraseList.length,
                          itemBuilder: (context, i){
                            return MyText(
                              text: "${i+1}. ${widget.passPhraseList[i]}",
                              textAlign: TextAlign.left,
                              fontSize: 25,
                              color: AppColors.secondarytext,
                              fontWeight: FontWeight.bold,
                            );
                          },
                        )
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: MyText(
                  textAlign: TextAlign.start,
                  text: AppString.screenshotNote,
                ),
              ),
            ),
            MyFlatButton(
              edgeMargin: const EdgeInsets.only(left: 66, right: 66, bottom: 16),
              textButton: AppString.next,
              hasShadow: true,
              action: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmMnemonic(
                      widget.passPhrase!,
                      widget.passPhraseList,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
