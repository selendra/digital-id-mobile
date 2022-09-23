import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/random_border_color.dart';
import 'package:wallet_apps/src/screen/home/id_detail/id_detail.dart';
import 'dart:math' as math;

class CardDocument extends StatelessWidget{

  final Map<String, dynamic>? data;

  final String? url;

  final bool? isDetail;

  final EdgeInsets? margin;

  final String? colorString;

  final String? textColor;

  final double? bottomPadding;

  CardDocument({
    required this.data, 
    this.url,
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
              // for(int i = 0; i < AppUtils.mapToList(data!['details']).length; i++){
              //   if (AppUtils.mapToList(data!['details'])[i].key.toString() == "avatar"){
              //     print(AppUtils.mapToList(data!['details'])[i].value);
              //   }
              // }
              // print("data ${AppUtils.mapToList(data!['details'])}");
              Navigator.push(context, Transition(child: IdDetail(data: data, url: url), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
            },
            child: ClipRect(
              child: MyBanner(
                isApprove: data!['isVerified'],
                color: data!['isVerified'] == false ? AppColors.txtSecondary : AppColors.txtPrimary,
                child: Card(
                  
                  margin: EdgeInsets.all(0),
                  // color: colorString != null ? hexaCodeToColor(colorString!) : hexaCodeToColor(data!['color']).withOpacity(0.4),
                  elevation: 0,
                  color: hexaCodeToColor(AppColors.newPrimary).withOpacity(0.2),//Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Column(
                    children: [

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 10,
                        width: 80,
                        decoration: BoxDecoration(
                          color: hexaCodeToColor(AppColors.bgColor),
                          borderRadius: BorderRadius.circular(18)
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 25.h,
                        margin: EdgeInsets.only(left: paddingSize, right: paddingSize, bottom: paddingSize),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            if (data!.containsKey('parent_data')) MyText(
                              top: paddingSize,
                              // bottom: paddingSize,
                              text: data!['parent_data']['details']['title'], 
                              color2: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold
                            ),
                        
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: paddingSize),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                                          
                                    // for (int i = 0; i < Map<String, dynamic>.from(data!['details']).length; i++)
                                    // if (AppUtils.mapToList(data!['details'])[i].key.toString() == "avatar")

                                    if (url != null)
                                    Container(
                                      height: 25.w,
                                      width: 25.w,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(url!),
                                      ),
                                    ) else 
                                    Container(
                                      height: 25.w,
                                      width: 25.w,
                                      // color: Colors.red,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Container(
                                          color: Colors.grey,
                                        ) ,
                                      ),
                                    ),
                                                      
                                    SizedBox(width: 2.w,),
                                                          
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          
                                          for (int i = 0; i < Map<String, dynamic>.from(data!['details']).length; i++)
                                          if (AppUtils.mapToList(data!['details'])[i].key.toString() != "avatar") Column(
                                            children: [
                                              SizedBox(height: 5,),
                                              i == 0 ?
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  MyText(
                                                    // width: 70,
                                                    fontSize: 17,
                                                    text: AppUtils.mapToList(data!['details'])[i].value.toString(),
                                                    color: textColor ?? AppColors.newText,
                                                    textAlign: TextAlign.left,
                                                    fontWeight: FontWeight.w500
                                                    // overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
                                              :
                                              Row(
                                                children: [
                                                  MyText(
                                                    // width: 70,
                                                    fontSize: i == 0 ? 18 : 15,
                                                    text: AppUtils.mapToList(data!['details'])[i].value.toString(),
                                                    color: textColor ?? AppColors.newText,
                                                    textAlign: TextAlign.left,
                                                    fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
                                                    // overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ],
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