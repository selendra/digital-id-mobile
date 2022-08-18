import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/id_detail/id_detail.dart';

class CardDocument extends StatelessWidget{

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
              Navigator.push(context, Transition(child: IdDetail(data: data), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
            },
            child: ClipRect(
              child: MyBanner(
                isApprove: data!['isApprove'],
                color: data!['isApprove'] == false ? AppColors.txtSecondary : AppColors.txtPrimary,
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: colorString != null ? hexaCodeToColor(colorString!) : hexaCodeToColor(data!['color']).withOpacity(0.4),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                
                              Container(
                                width: 33.w,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.asset("assets/4x6.jpg", fit: BoxFit.cover,),
                                )
                              ),
                                
                              SizedBox(width: 5.w,),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  
                                    MyText(
                                      textAlign: TextAlign.start,
                                      text: data!['type'],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: textColor ?? AppColors.newText,
                                    ),
                              
                                    SizedBox(height: 3.h,),
                              
                                    Row(
                                      children: [
                                        MyText(
                                          fontSize: 14,
                                          text: 'ID: ',
                                          fontWeight: FontWeight.bold, 
                                          color: textColor ?? AppColors.newText,
                                        ),
                                        MyText(
                                          fontSize: 14,
                                          text: '${data!['id']}',
                                          color: textColor ?? AppColors.newText,
                                        ),
                                      ],
                                    ),
                                  
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        MyText(
                                          fontSize: 14,
                                          text: 'Name: ',
                                          fontWeight: FontWeight.bold,
                                          color: textColor ?? AppColors.newText,
                                        ),
                                        MyText(
                                          fontSize: 14,
                                          text: '${data!['name']}',
                                          color: textColor ?? AppColors.newText,
                                        ),
                                      ],
                                    ),
                              
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        MyText(
                                          fontSize: 14,
                                          text: 'DOB: ',
                                          fontWeight: FontWeight.bold,
                                          color: textColor ?? AppColors.newText,
                                        ),
                                        MyText(
                                          fontSize: 14,
                                          text: '${data!['dob']}',
                                          color: textColor ?? AppColors.newText,
                                        ),
                                      ],
                                    ),
                              
                                    SizedBox(height: 5,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          fontSize: 14,
                                          text: 'Address: ',
                                          fontWeight: FontWeight.bold,
                                          color: textColor ?? AppColors.newText,
                                        ),
                                        MyText(
                                          width: 20.w,
                                          fontSize: 14,
                                          textAlign: TextAlign.start,
                                          // width: MediaQuery.of(context).size.width / 1.5,
                                          text: '${data!['address']}',
                                          color: textColor ?? AppColors.newText,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                              
                                    SizedBox(height: 5,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          fontSize: 14,
                                          text: 'Expired date: ',
                                          fontWeight: FontWeight.bold,
                                          color: textColor ?? AppColors.newText,
                                        ),
                                        MyText(
                                          width: 20.w,
                                          fontSize: 14,
                                          textAlign: TextAlign.start,
                                          // width: MediaQuery.of(context).size.width / 1.5,
                                          text: '${data!['expired_date']}',
                                          color: textColor ?? AppColors.newText,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                              
                                    Expanded(child: Container()),
                              
                                    isDetail == true ? Container() : Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: 20.w,
                                        height: 3.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: hexaCodeToColor(AppColors.primary), width: 2),
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        alignment: Alignment.center,
                                        child: MyText(
                                          text: "Detail",
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    
          // If Detail remove Bottom Padding
          colorString == null ? SizedBox(height: bottomPadding ?? paddingSize.sp,) : Container()
        ],
      ),
    );
  }
}