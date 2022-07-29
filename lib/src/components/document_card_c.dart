import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/id_detail/id_detail.dart';

class CardDocument extends StatelessWidget{

  final Map<String, dynamic>? data;

  final bool? isDetail;

  CardDocument({required this.data, required this.isDetail});
  
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: isDetail == true ? null : () async {
        Navigator.push(context, Transition(child: IdDetail(data: data), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ClipRect(
          child: MyBanner(
            isApprove: data!['isApprove'],
            color: data!['isApprove'] == false ? AppColors.txtSecondary : AppColors.txtPrimary,
            child: Card(
              margin: EdgeInsets.all(0),
              color: hexaCodeToColor(data!['color']).withOpacity(0.4),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 25.h,
                padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize),
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
                              child: Image.asset("assets/avatar.jpeg", fit: BoxFit.cover,),
                            )
                          ),
                            
                          SizedBox(width: 5.w,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                                MyText(
                                  textAlign: TextAlign.start,
                                  text: 'National ID',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  
                                ),
                          
                                SizedBox(height: 3.h,),
                          
                                Row(
                                  children: [
                                    MyText(
                                      fontSize: 14,
                                      text: 'ID: ',
                                      fontWeight: FontWeight.bold,
                                      
                                    ),
                                    MyText(
                                      fontSize: 14,
                                      text: '${data!['id']}',
                                      
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
                                      
                                    ),
                                    MyText(
                                      fontSize: 14,
                                      text: '${data!['name']}',
                                      
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
                                      
                                    ),
                                    MyText(
                                      fontSize: 14,
                                      text: '${data!['dob']}',
                                      
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
                                      
                                    ),
                                    MyText(
                                      width: 20.w,
                                      fontSize: 14,
                                      textAlign: TextAlign.start,
                                      // width: MediaQuery.of(context).size.width / 1.5,
                                      text: '${data!['address']}',
                                      
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
                                      
                                    ),
                                    MyText(
                                      width: 20.w,
                                      fontSize: 14,
                                      textAlign: TextAlign.start,
                                      // width: MediaQuery.of(context).size.width / 1.5,
                                      text: '${data!['address']}',
                                      
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
    );
  }
}