import 'package:digital_id/all_export.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IdDetailBody extends StatelessWidget {
  const IdDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text('National ID'),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.scan,
              color: Colors.white,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Column(
        children: [
          _idCard(context),

          SizedBox(height: paddingSize),

          _cardInformation(context),
        ],
      ),
    );
  }

    Widget _idCard(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.all(0),
            color: whiteColor.withOpacity(0.06),
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
                        text: 'ID: 000000000',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
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
                            child: SvgPicture.asset("assets/logos/selendra.svg", width: 50)
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
                                    color: AppColors.whiteColor,
                                  ),
                                  MyText(
                                    fontSize: 14,
                                    text: 'Sam Allen',
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
                                    text: '09.02.2000',
                                    color: AppColors.whiteColor,
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
                                      color: AppColors.whiteColor,
                                    ),
                                    Expanded(
                                      child: MyText(
                                        fontSize: 14,
                                        textAlign: TextAlign.start,
                                        // width: MediaQuery.of(context).size.width / 1.5,
                                        text: 'Tik L`lork, Toul Kork, Phnom Penh',
                                        color: AppColors.whiteColor,
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
                color: HexColor('#FFD90F').withOpacity(0.3),
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
                color: AppColors.whiteColor,
              ),
              MyText(
                fontSize: 14,
                text: 'Sam Allen',
                color: AppColors.whiteColor,
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
                color: AppColors.whiteColor,
              ),
              MyText(
                fontSize: 14,
                text: '09.02.2000',
                color: AppColors.whiteColor,
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
                color: AppColors.whiteColor,
              ),
              MyText(
                fontSize: 14,
                textAlign: TextAlign.start,
                // width: MediaQuery.of(context).size.width / 1.5,
                text: 'Tik L`lork, Toul Kork, Phnom Penh',
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

}