import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/document_card_c.dart';
import 'package:wallet_apps/src/screen/home/id_detail/share_id/share_id.dart';

class IdDetailBody extends StatelessWidget {

  final Map<String, dynamic>? data;

  IdDetailBody({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: hexaCodeToColor(AppColors.textColor)),
        titleSpacing: 0,
        elevation: 0,
        title: MyText(text: data!['type'], color: AppColors.textColor,),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.scan_barcode,
              color: hexaCodeToColor(AppColors.textColor),
            ),
            onPressed: () {
              Navigator.push(context, Transition(child: ShareID(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(paddingSize),
        child: Column(
          children: [

            CardDocument(data: data!, isDetail: true,),

            SizedBox(height: paddingSize),

            _cardInformation(context),
          ],
        ),
      ),
    );
  }

  Widget _idCard(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(8),
      child: Stack(
        children: [

          
          Card(
            margin: EdgeInsets.all(0),
            color: Colors.white.withOpacity(0.06),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: data!['type'],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ],
                  ),
                  SizedBox(height: paddingSize,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  MyText(
                                    fontSize: 14,
                                    text: 'Name: ',
                                    fontWeight: FontWeight.bold,
                                    
                                    color: AppColors.textColor,
                                  ),
                                  MyText(
                                    fontSize: 14,
                                    text: data!['name'],
                                    
                                    color: AppColors.textColor,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MyText(
                                    fontSize: 14,
                                    text: 'Date Of Birth: ',
                                    fontWeight: FontWeight.bold,
                                    
                                    color: AppColors.textColor,
                                  ),
                                  MyText(
                                    fontSize: 14,
                                    text: data!['dob'],
                                    
                                    color: AppColors.textColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      fontSize: 14,
                                      text: 'Address: ',
                                      fontWeight: FontWeight.bold,
                                      
                                    color: AppColors.textColor,
                                    ),
                                    Expanded(
                                      child: MyText(
                                        fontSize: 14,
                                        textAlign: TextAlign.start,
                                        // width: MediaQuery.of(context).size.width / 1.5,
                                        text: data!['address'],
                                        
                                    color: AppColors.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration:  BoxDecoration(
                color: hexaCodeToColor('#FFD90F').withOpacity(0.3),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: MyText(
                text: 'Verifying',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: "#FFD90F",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardInformation(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              MyText(
                fontSize: 14,
                text: 'Name: ',
                fontWeight: FontWeight.bold,
                
                                    color: AppColors.textColor,
              ),
              MyText(
                fontSize: 14,
                text: data!['name'],
                
                                    color: AppColors.textColor,
              ),
            ],
          ),

          SizedBox(height: 10,),

          Row(
            children: [
              MyText(
                fontSize: 14,
                text: 'Date Of Birth: ',
                fontWeight: FontWeight.bold,
                
                                    color: AppColors.textColor,
              ),
              MyText(
                fontSize: 14,
                text: data!['dob'],
                
                                    color: AppColors.textColor,
              ),
            ],
          ),

          SizedBox(height: 10,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                fontSize: 14,
                text: 'Address: ',
                fontWeight: FontWeight.bold,
                
                                    color: AppColors.textColor,
              ),
              MyText(
                fontSize: 14,
                textAlign: TextAlign.start,
                // width: MediaQuery.of(context).size.width / 1.5,
                text: data!['address'],
                
                                    color: AppColors.textColor,
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
                
                                    color: AppColors.textColor,
              ),
              MyText(
                fontSize: 14,
                textAlign: TextAlign.start,
                // width: MediaQuery.of(context).size.width / 1.5,
                text: data!['address'],
                
                                    color: AppColors.textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

}