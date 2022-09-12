import 'package:flip_card/flip_card.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:wallet_apps/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_apps/src/components/acc_c.dart';
import 'package:wallet_apps/src/components/appbar_c.dart';
import 'package:wallet_apps/src/components/document_card_c.dart';
import 'package:wallet_apps/src/components/shimmer_c.dart';
import 'package:wallet_apps/src/models/account.m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/src/screen/home/menu/account/c_account.dart';
import 'package:wallet_apps/src/screen/home/menu/backup/body_backup_key.dart';
import 'package:wallet_apps/src/screen/home/menu/changePin/changePin.dart';

class AccountBody extends StatelessWidget{

  final AccountM? accountModel;
  final Function? onSubmitName;
  final Function? onChangeName;
  final Function? onChangedBackup;
  final Function? onChangedChangePin;
  final Function? onSubmitChangePin;
  final Function? onSubmit;
  final Function? submitChangePin;
  final Function? submitBackUpKey;
  final Function? changeName;
  final Function? deleteAccout;

  AccountBody({
    this.accountModel, 
    this.onSubmitName,
    this.onChangeName,
    this.onChangedBackup, 
    this.onSubmit,
    this.onChangedChangePin, 
    this.onSubmitChangePin, 
    this.submitChangePin, 
    this.submitBackUpKey, 
    this.changeName, 
    this.deleteAccout
  });

  Widget build(BuildContext context){
    final isDarkTheme = Provider.of<ThemeProvider>(context).isDark;
    return Scaffold(
      body: Consumer<ApiProvider>(
        builder: (context, provider, widget){

          return provider.accountM.name == null ? 
          Center(
            child: CircularProgressIndicator(),
          )
           : BodyScaffold(
            physic: BouncingScrollPhysics(),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
        
                // CardDocument(data: Provider.of<DocumentProvider>(context).kycDocs.approve[0], isDetail: false,),
                Padding(
                  padding: EdgeInsets.all(paddingSize),
                  child: FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    front: CardDocument(data: Provider.of<DocumentProvider>(context).docsModel.approve[0], isDetail: true, margin: EdgeInsets.zero, colorString: "#073444", textColor: "#FFFFFF"),
                    back: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child: Container(
                        height: 25.h,
                        color: hexaCodeToColor("#073444"),
                        child: Column(
        
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/SelendraQr-1.png", height: 10.h,),
                
                            Column(
                              children: [
                                MyText(
                                  text: provider.accountM.name ?? '',
                                  color: AppColors.whiteColor,
                                  fontSize: 20,
                                ),
            
                                Padding(
                                  padding: const EdgeInsets.all(paddingSize),
                                  child:WidgetShimmer(
                                    txt: provider.accountM.address, 
                                    child: MyText(
                                      right: 5,
                                      text: provider.accountM.address,
                                      color: AppColors.whiteColor,
                                      fontSize: 16,
                                    )
                                  ),
                                )
            
                              ],
                            )
                          ],
                        ),
                      )
                    )
                  ),
                ),
        
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(8),
                    //   color: isDarkTheme
                    //     ? Colors.white.withOpacity(0.06)
                    //     : hexaCodeToColor(AppColors.whiteHexaColor),
                    //   boxShadow: [shadow(context)]
                    // ),
                    child: Column(
                      children: [
                        ListTileComponent(
                          action: (){
                            // underContstuctionAnimationDailog(context: context);
                            AccountC().showEditName(
                              context,
                              accountModel!.editNameKey,
                              accountModel!.editNameController,
                              accountModel!.newNode,
                              onChangeName!,
                              changeName
                            );
                          },
                          text: 'Edit Wallet Name',
                        ),
                        
                        ListTileComponent(
                          action: (){
                            // underContstuctionAnimationDailog(context: context);
                            // AccountC().showBackup(
                            //   context,
                            //   accountModel!.backupKey,
                            //   accountModel!.pinController,
                            //   accountModel!.pinNode,
                            //   onChangedBackup!,
                            //   onSubmit!,
                            //   submitBackUpKey!,
                            // );
                            Navigator.push(
                              context, 
                              Transition(
                                child: BackUpKeyBody(),
                                transitionEffect: TransitionEffect.RIGHT_TO_LEFT
                              )
                            );
                          },
                          text: 'Backup Key',
                        ),
                        
                        // const SizedBox(height: 20),
                        
                        ListTileComponent(
                          action: ()  async {
                            // underContstuctionAnimationDailog(context: context);
                            // Passcode(label: PassCodeLabel.formChangePin);
                            // AccountC().showChangePin(
                            //   context,
                            //   accountModel!.changePinKey,
                            //   accountModel!.oldPinController,
                            //   accountModel!.newPinController,
                            //   accountModel!.oldNode,
                            //   accountModel!.newNode,
                            //   onChangedChangePin!,
                            //   onSubmitChangePin!,
                            //   submitChangePin!,
                            // );
        
                            final res = await Navigator.push(
                              context, 
                              Transition(
                                child: ChangePin(),
                                transitionEffect: TransitionEffect.RIGHT_TO_LEFT
                              )
                            );
        
                            // await Provider.of<ApiProvider>(context, listen: false).
                          },
                          text: 'Change Pin',
                        ),
        
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            // await contract.unsubscribeNetwork();
                            await deleteAccout!();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // margin: const EdgeInsets.only(left: 16, right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red.withOpacity(0.3)
                            ),
                            height: 7.h,
                            child: MyText(
                              text: 'Log Out',
                              color: "#FF0000",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}