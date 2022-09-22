import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/random_border_color.dart';
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
              child: RandomColorBorder(
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
                          
                                Expanded(
                                  child: Column(
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
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                MyText(
                                                  width: 70,
                                                  fontSize: 15,
                                                  text: AppUtils.mapToList(data!['details'])[i].value.toString(),
                                                  color: textColor ?? AppColors.newText,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
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
                          )
                          
                        ],
                      ),
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