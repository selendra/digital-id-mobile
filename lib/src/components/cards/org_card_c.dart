import 'package:wallet_apps/index.dart';

class OrgCardComponent extends StatelessWidget{

  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(paddingSize),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [

          Row(
            children: [

              MyText(
                text: "Image"
              ),

              MyText(
                color2: Colors.white,
                text: "Image"
              ),
            ],
          ),

          Divider(color: Colors.white,),

          Row(
            children: [

              MyText(
                color2: Colors.white,
                text: "Image"
              ),

              MyText(
                color2: Colors.white,
                text: "Image"
              ),
            ],
          ),

          Row(
            children: [

              MyText(
                color2: Colors.white,
                text: "Image"
              ),

              MyText(
                color2: Colors.white,
                text: "Image"
              ),
            ],
          ),

          Row(
            children: [

              MyText(
                color2: Colors.white,
                text: "Image"
              ),

              MyText(
                color2: Colors.white,
                text: "Image"
              ),
            ],
          )
        ],
      )
    );
  }
}