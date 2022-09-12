// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wallet_apps/index.dart';
// import 'package:wallet_apps/src/constants/db_key_con.dart';
// import '../screen/home/menu/account/c_account.dart';
// import '../screen/home/menu/backup/backup_key.dart';
// import '../screen/home/menu/backup/body_backup_key.dart';
//
// class CardSection {
//   final String? title;
//   final String? trailingTitle;
//   final IconData? leadingIcon;
//   final Function? action;
//
//   CardSection({this.title, this.trailingTitle, this.leadingIcon, this.action});
// }
//
//
// List<CardSection> settingsAccSection({BuildContext? context}) {
//   return [
//     CardSection(
//         title:'Edit Name',
//         leadingIcon: Iconsax.lock_1,
//         action: () {
//           AccountC().showEditName(
//               context!,
//               accountModel!.editNameKey,
//               accountModel!.editNameController,
//               accountModel!.newNode,
//               onChangeName!,
//               changeName
//           );
//         }
//     ),
//     CardSection(
//         title: 'Backup Key',
//         leadingIcon: Iconsax.personalcard,
//         action: () {
//           Navigator.push(
//               context!,
//               Transition(
//                 child: BackUpKey(),
//                 transitionEffect: TransitionEffect.RIGHT_TO_LEFT
//               )
//           );
//         }
//     ),
//
//     CardSection(
//         title: 'Change PIN',
//         leadingIcon: Iconsax.personalcard,
//         action: () {
//           Navigator.push(
//               context!,
//               Transition(
//                 child: BackUpKey(),
//                 transitionEffect: TransitionEffect.RIGHT_TO_LEFT
//               )
//           );
//         }
//     ),
//   ];
// }
//
//
// List<CardSection> settingsLogoutSection({BuildContext? context}) {
//   return [
//     CardSection(
//         title: 'Logout',
//         leadingIcon: Iconsax.logout,
//         action: () async {
//           await deleteAccount(context: context!);
//         }
//     ),
//   ];
// }
//
// Future<void> deleteAccount({BuildContext? context}) async {
//   await customDialog(
//     context!,
//     'Delete account',
//     'Are you sure to delete your account?',
//     btn2: TextButton(
//       onPressed: () async => await _deleteAccount(context: context),
//       child: MyText(
//           text: 'Delete',
//           color: AppColors.redColor,
//           fontWeight: FontWeight.w700
//       ),
//     ),
//   );
// }
//
// Future<void> _deleteAccount({BuildContext? context}) async {
//
//   dialogLoading(context!);
//
//   final api = Provider.of<ApiProvider>(context, listen: false);
//
//   try {
//     await api.apiKeyring.deleteAccount(
//       api.getKeyring,
//       api.getKeyring.keyPairs[0],
//     );
//
//     final mode = await StorageServices.fetchData(DbKey.themeMode);
//     // final event = await StorageServices.fetchData(DbKey.event);
//
//     await StorageServices().clearStorage();
//
//     final pref = await SharedPreferences.getInstance();
//     String? value = pref.getString("session");
//     if (kDebugMode) {
//       print("value ${value ?? 'null'}");
//     }
//
//     // Re-Save Them Mode
//     await StorageServices.storeData(mode, DbKey.themeMode);
//     // await StorageServices.storeData(event, DbKey.event);
//
//     await StorageServices().clearSecure();
//
//     Provider.of<ContractProvider>(context, listen: false).resetConObject();
//
//     await Future.delayed(const Duration(seconds: 2), () {});
//
//     Provider.of<WalletProvider>(context, listen: false).clearPortfolio();
//
//     Navigator.pushAndRemoveUntil(context, RouteAnimation(enterPage: Welcome()), ModalRoute.withName('/'));
//   } catch (e) {
//     if (ApiProvider().isDebug == true) {
//       if (kDebugMode) {
//         print("_deleteAccount ${e.toString()}");
//       }
//     }
//     // await dialog(context, e.toString(), 'Opps');
//   }
// }