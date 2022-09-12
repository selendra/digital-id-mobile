// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../index.dart';

// class AttActivity extends StatelessWidget {
//   final List<Map> _checkAll;
 
//   final Future<void> Function() _onRefresh;

//   const AttActivity(
//     this._checkAll,
    
//     this._onRefresh,
//   );

//   @override
//   Widget build(BuildContext context) {
//     final atd = Provider.of<ContractProvider>(context).atd;
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 8.0),
//         child: RefreshIndicator(
//           onRefresh: _onRefresh,
//           child: _checkAll.isEmpty
//               ? Center(
//                   child: SvgPicture.asset(
//                     'assets/icons/no_data.svg',
//                     width: 180,
//                     height: 180,
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: _checkAll.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsets.only(
//                         left: 16,
//                         right: 16,
//                         bottom: 16,
//                       ),
//                       padding: const EdgeInsets.fromLTRB(
//                         15,
//                         9,
//                         15,
//                         9,
//                       ),
//                       height: 90,
//                       decoration: BoxDecoration(
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 2.0,
//                             offset: Offset(1.0, 1.0),
//                           )
//                         ],
//                         color: hexaCodeToColor(AppColors.whiteHexaColor),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 50,
//                             height: 50,
//                             padding: const EdgeInsets.all(6),
//                             margin: const EdgeInsets.only(right: 20),
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                             child: Image.asset(
//                               atd.logo,
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               margin: const EdgeInsets.only(right: 16),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   MyText(
//                                     text: atd.symbol,
//                                     color: "#FFFFFF",
//                                   ),
//                                   MyText(
//                                     textAlign: TextAlign.start,
//                                     text:
//                                         _checkAll[index]['location'].toString(),
//                                     fontSize: 14,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               margin: const EdgeInsets.only(
//                                 right: 16,
//                                 top: 10,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   MyText(
//                                     width: double.infinity,
//                                     text: _checkAll[index]['time'].toString() ??
//                                         "",
//                                     color: "#FFFFFF",
//                                     fontSize: 12,
//                                     textAlign: TextAlign.right,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerRight,
//                                       child: Container(
//                                         height: 10,
//                                         width: 10,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color:
//                                               _checkAll[index]['status'] == true
//                                                   ? Colors.green
//                                                   : Colors.red,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//         ),
//       ),
//     );
//   }
// }
