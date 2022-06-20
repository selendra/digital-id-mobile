
import '../all_export.dart';

class BuildLineTop extends StatelessWidget {
  const BuildLineTop({
    Key? key,
    @required this.context,
  }) : super(key: key);

  final BuildContext? context;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: 100,
        height: 3,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
