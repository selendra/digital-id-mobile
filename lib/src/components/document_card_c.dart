import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/id_detail/id_detail.dart';

class CardDocument extends StatelessWidget{

  /// 
  final Map<String, dynamic>? data;

  final bool? isDetail;

  final EdgeInsets? margin;

  final String? colorString;

  final String? textColor;

  final double? bottomPadding;

  CardDocument({
    required this.data, 
    required this.isDetail, 
    this.margin = const EdgeInsets.symmetric(horizontal: paddingSize), 
    this.colorString, this.textColor,
    this.bottomPadding
  });
  
  Widget build(BuildContext context){
    return Container(
      margin: margin,
      child: Column(
        children: [
    
          GestureDetector(
            onTap: isDetail == true ? null : () async {
              print("AppUtils.mapToList(data!['details']).length ${AppUtils.mapToList(data!['details']).length}");
              for(int i = 0; i < AppUtils.mapToList(data!['details']).length; i++){
                if (AppUtils.mapToList(data!['details'])[i].key.toString() == "avatar"){
                  print(AppUtils.mapToList(data!['details'])[i].value);
                }
              }
              // print("data ${AppUtils.mapToList(data!['details'])}");
              // Navigator.push(context, Transition(child: IdDetail(data: data), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
            },
            child: ClipRect(
              child: MyBanner(
                isApprove: data!['isVerified'],
                color: data!['isVerified'] == false ? AppColors.txtSecondary : AppColors.txtPrimary,
                child: Card(
                  margin: EdgeInsets.all(0),
                  // color: colorString != null ? hexaCodeToColor(colorString!) : hexaCodeToColor(data!['color']).withOpacity(0.4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 25.h,
                    padding: EdgeInsets.all(paddingSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Expanded(
                          child: Row(
                            children: [
                        
                              for (int i = 0; i < Map<String, dynamic>.from(data!['details']).length; i++)
                              if (AppUtils.mapToList(data!['details'])[i].key.toString() == "avatar")
                              Container(
                                width: 33.w,
                                height: 21.h  ,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.network( AppUtils.mapToList(data!['details'])[i].value[0], fit: BoxFit.cover,),
                                )
                              ),

                              SizedBox(width: 2.w,),
                        
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                        
                                  for (int i = 0; i < Map<String, dynamic>.from(data!['details']).length; i++)
                                  if (AppUtils.mapToList(data!['details'])[i].key.toString() != "avatar") Column(
                                    children: [
                                      SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            MyText(
                                              fontSize: 15,
                                              text: '${AppUtils.mapToList(data!['details'])[i].key.toString().toUpperCase()}:  ',
                                              fontWeight: FontWeight.bold,
                                              color: textColor ?? AppColors.newText,
                                            ),
                                            MyText(
                                              fontSize: 15,
                                              text: AppUtils.mapToList(data!['details'])[i].value.toString(),
                                              color: textColor ?? AppColors.newText,
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )

                      //   List<Widget>.generate(.length, (index){
                      //     return Container(
                      //       // width: 33.w,
                      //       // height: 5,
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: Colors.white,
                      //         ),
                      //         borderRadius: BorderRadius.circular(18),
                      //       ),
                      //       child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(18),
                      //         child: Text(AppUtils.mapToList(data!['details'])[index].value.toString())//Image.network( , fit: BoxFit.cover,),
                      //       )
                      //     );
                      //   })
                      // ]
                      // List<Widget>.generate(Map<String, dynamic>.from(data!['details']).length, (index){
                      //   return Container(
                      //     // width: 33.w,
                      //     // height: 5,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: Colors.white,
                      //       ),
                      //       borderRadius: BorderRadius.circular(18),
                      //     ),
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(18),
                      //       child: Text(AppUtils.mapToList(data!['details'])[index].value.toString())//Image.network( , fit: BoxFit.cover,),
                      //     )
                      //   );
                      // })
                      
                      // List<Widget>.generate(Map<String, dynamic>.from(data!['details']).entries.length, (index) {
                      //   return Expanded(
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                                
                        //       Container(
                        //         width: 33.w,
                        //         height: double.infinity,
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //             color: Colors.white,
                        //           ),
                        //           borderRadius: BorderRadius.circular(18),
                        //         ),
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(18),
                        //           child: Image.network(data![], fit: BoxFit.cover,),
                        //         )
                        //       ),
                                
                        //       SizedBox(width: 5.w,),
                        //       Flexible(
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                                  
                        //             MyText(
                        //               textAlign: TextAlign.start,
                        //               text: data!['type'],
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.bold,
                        //               color: textColor ?? AppColors.newText,
                        //             ),
                              
                        //             SizedBox(height: 3.h,),
                              
                        //             Row(
                        //               children: [
                        //                 MyText(
                        //                   fontSize: 14,
                        //                   text: 'CID: ',
                        //                   fontWeight: FontWeight.bold, 
                        //                   color: textColor ?? AppColors.newText,
                        //                 ),
                        //                 MyText(
                        //                   fontSize: 14,
                        //                   text: '${data!['id']}',
                        //                   color: textColor ?? AppColors.newText,
                        //                 ),
                        //               ],
                        //             ),
                                  
                        //             SizedBox(height: 5,),
                        //             Row(
                        //               children: [
                        //                 MyText(
                        //                   fontSize: 14,
                        //                   text: 'Name: ',
                        //                   fontWeight: FontWeight.bold,
                        //                   color: textColor ?? AppColors.newText,
                        //                 ),
                        //                 MyText(
                        //                   fontSize: 14,
                        //                   text: '${data!['name']}',
                        //                   color: textColor ?? AppColors.newText,
                        //                 ),
                        //               ],
                        //             ),
                              
                        //             SizedBox(height: 5,),
                        //             Row(
                        //               children: [
                        //                 MyText(
                        //                   fontSize: 14,
                        //                   text: 'Full name: ',
                        //                   fontWeight: FontWeight.bold,
                        //                   color: textColor ?? AppColors.newText,
                        //                 ),
                        //                 MyText(
                        //                   fontSize: 14,
                        //                   text: '${data!['dob']}',
                        //                   color: textColor ?? AppColors.newText,
                        //                 ),
                        //               ],
                        //             ),
                              
                        //             SizedBox(height: 5,),
                        //             Row(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 MyText(
                        //                   fontSize: 14,
                        //                   text: 'Gender: ',
                        //                   fontWeight: FontWeight.bold,
                        //                   color: textColor ?? AppColors.newText,
                        //                 ),
                        //                 MyText(
                        //                   width: 20.w,
                        //                   fontSize: 14,
                        //                   textAlign: TextAlign.start,
                        //                   // width: MediaQuery.of(context).size.width / 1.5,
                        //                   text: '${data!['address']}',
                        //                   color: textColor ?? AppColors.newText,
                        //                   overflow: TextOverflow.ellipsis,
                        //                 ),
                        //               ],
                        //             ),
                              
                        //             // SizedBox(height: 5,),
                        //             // Row(
                        //             //   crossAxisAlignment: CrossAxisAlignment.start,
                        //             //   children: [
                        //             //     MyText(
                        //             //       fontSize: 14,
                        //             //       text: 'Expired date: ',
                        //             //       fontWeight: FontWeight.bold,
                        //             //       color: textColor ?? AppColors.newText,
                        //             //     ),
                        //             //     MyText(
                        //             //       width: 20.w,
                        //             //       fontSize: 14,
                        //             //       textAlign: TextAlign.start,
                        //             //       // width: MediaQuery.of(context).size.width / 1.5,
                        //             //       text: '${data!['expired_date']}',
                        //             //       color: textColor ?? AppColors.newText,
                        //             //       overflow: TextOverflow.ellipsis,
                        //             //     ),
                        //             //   ],
                        //             // ),
                              
                        //             Expanded(child: Container()),
                              
                        //             isDetail == true ? Container() : Align(
                        //               alignment: Alignment.bottomRight,
                        //               child: Container(
                        //                 width: 20.w,
                        //                 height: 3.h,
                        //                 decoration: BoxDecoration(
                        //                   border: Border.all(color: hexaCodeToColor(AppColors.primary), width: 2),
                        //                   borderRadius: BorderRadius.circular(20)
                        //                 ),
                        //                 alignment: Alignment.center,
                        //                 child: MyText(
                        //                   text: "Detail",
                        //                   color: AppColors.primary,
                        //                 ),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                      //       ],
                      //     ),
                      //   );
                      // })
                      // [


                        
                      
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    
          // // If Detail remove Bottom Padding
          colorString == null ? SizedBox(height: bottomPadding ?? paddingSize.sp,) : Container()
        ],
      ),
    );
  }
}