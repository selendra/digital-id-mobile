
import 'package:wallet_apps/index.dart';

class ReuseDotIndecator extends StatelessWidget {
  final int? indexPoint;
  const ReuseDotIndecator({
    Key? key,
    required this.indexPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(3, (int index) {
        return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 10,
            width: (index == indexPoint) ? 30 : 10,
            margin:
                EdgeInsets.symmetric(horizontal: 5, vertical: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: (index == indexPoint)
                    ? Colors.blue
                    : Colors.blue.withOpacity(0.5)));
      }
      )
    );
  }
}
