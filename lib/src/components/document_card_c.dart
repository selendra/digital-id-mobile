import 'package:wallet_apps/index.dart';

class CardDocument extends StatelessWidget{

  Map<String, dynamic>? data;

  CardDocument({required this.data});
  
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () async {
        // Navigator.push(context, Transition(child: IdDetail(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [

            ClipRect(
              child: Banner(
                message: "Pending", 
                textStyle: TextStyle(fontSize: 12.sp),
                location: BannerLocation.topEnd,
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: hexaCodeToColor(AppColors.primary),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                              text: '${data!['type']}',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        ),
            
                        SizedBox(
                          height: 14.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
            
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: SvgPicture.asset("assets/male_avatar.svg", width: 50)
                              ),
            
                              const SizedBox(width: 5,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
            
                                  
                                  MyText(
                                    textAlign: TextAlign.start,
                                    text: 'ID: ${data!['id']}',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
            
                                  Row(
                                    children: [
                                      MyText(
                                        fontSize: 14,
                                        text: 'Name: ',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                      ),
                                      MyText(
                                        fontSize: 14,
                                        text: '${data!['id']}',
                                        color: AppColors.whiteColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                        fontSize: 14,
                                        text: 'Date Of Birth: ',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                      ),
                                      MyText(
                                        fontSize: 14,
                                        text: '${data!['dob']}',
                                        color: AppColors.whiteColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        fontSize: 14,
                                        text: 'Address: ',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                      ),
                                      MyText(
                                        fontSize: 14,
                                        textAlign: TextAlign.start,
                                        // width: MediaQuery.of(context).size.width / 1.5,
                                        text: '${data!['address']}',
                                        color: AppColors.whiteColor,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
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

            // Positioned(
            //   right: 0,
            //   top: 0,
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //     decoration:  BoxDecoration(
            //       color: hexaCodeToColor(data!['isVeried'] ? '#36CE00' : "#FFD90F").withOpacity(0.3),
            //       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
            //     ),
            //     child: MyText(
            //       text: '${data!['status']}',
            //       fontWeight: FontWeight.bold,
            //       color: data!['isVeried'] ? '#36CE00' : "#FFD90F",
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}