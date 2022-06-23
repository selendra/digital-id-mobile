// import 'package:flutter/material.dart';

// import 'back_side/back_side.dart';
// import 'front_side/front_side.dart';
// import 'selfie/selfie.dart';

// class Landing extends StatefulWidget {
//   const Landing({Key? key}) : super(key: key);

//   @override
//   _LandingState createState() => _LandingState();
// }

// class _LandingState extends State<Landing> {
//   int _currentPage = 0;
//   PageController _controller = PageController();

//   List<Widget> _pages = [
//     const FrontSide(),
//     const BackSide(),
//     const SelfieSide()
//   ];

//   _onchanged(int index) {
//     setState(() {
//       _currentPage = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           PageView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             scrollDirection: Axis.horizontal,
//             onPageChanged: _onchanged,
//             controller: _controller,
//             itemCount: _pages.length,
//             itemBuilder: (context, int index) {
//               return _pages[index];
//             },
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List<Widget>.generate(_pages.length, (int index) {
//                   return AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     height: 10,
//                     width: (index == _currentPage) ? 30 : 10,
//                     margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: (index == _currentPage)
//                         ? Colors.blue
//                         : Colors.blue.withOpacity(0.5)
//                     )
//                   );
//                 })
//               ),
//               SizedBox(
//                 height: 70,
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }