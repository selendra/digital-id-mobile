import 'package:wallet_apps/index.dart';

/// [Hole] provides a custom painter for leaving a circular hole with some
/// fuziness.
class Hole extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 100;
    double blurRadius = 0;

    canvas.drawRect(
      Rect.fromCenter(
            height: 250,
            width: 250,
            center: Offset(0.0, -100.0)),

       Paint()
        ..blendMode = BlendMode.xor
        // The mask filter gives some fuziness to the cutout.
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius),
    );
    // canvas.drawCircle(
    //   Offset(0, -100),
    //   radius,
      // Paint()
      //   ..blendMode = BlendMode.xor
      //   // The mask filter gives some fuziness to the cutout.
      //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius),
    // );
  }

  @override
  bool shouldRepaint(Hole oldDelegate) => false;
}
