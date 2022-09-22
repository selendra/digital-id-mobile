import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wallet_apps/index.dart';
import 'dart:math' as math;

class RandomColorBorder extends StatelessWidget {

  final Widget? child;

  const RandomColorBorder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: hexaCodeToColor(AppColors.blue),
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3) //hexaCodeToColor(doc['color'] ?? '#FFFFFF')//Colors.primaries[_random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100],
      ),
      padding: EdgeInsets.only(top: 1, bottom: 5, left: 1, right: 1,),
      // Data Inside Card
      child: child
    );
  }
}