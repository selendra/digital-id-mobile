import 'package:digital_id/all_export.dart';

class ImageEditComponent extends StatelessWidget{
  
  final Widget? image;
  final Function? action;

  /// Custom Widget That For Image With Edit Icon Button
  ImageEditComponent({ Key? key,this.image, this.action}) : super(key: key);

  Widget build(BuildContext context){
    return Stack(
      children: [
        image!,

        // Positioned(
        //   top: 5,
        //   right: 5,
        //   child: IconButton(
        //     onPressed: (){
        //       action!();
        //     }, 
        //     icon: Container(
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Colors.white
        //       ),
        //       padding: EdgeInsets.all(5),
        //       child: Icon(Icons.edit_outlined),
        //     )
        //   ),
        // )
      ],
    );
  }
}