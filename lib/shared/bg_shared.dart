import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class TestGlasUI extends StatefulWidget {
  final Widget? body;
  const TestGlasUI({ Key? key,this.body }) : super(key: key);

  @override
  _TestGlasUIState createState() => _TestGlasUIState();
}

class _TestGlasUIState extends State<TestGlasUI> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          drawerScrimColor: Colors.black.withOpacity(0.2),
          extendBodyBehindAppBar: true,
          body: widget.body,
        ),
      ],
    );
  }
}




class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;
  const GlassMorphism({
    Key? key,
    required this.child,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(start),
                Colors.white.withOpacity(end),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}


class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://t4.ftcdn.net/jpg/04/10/47/43/240_F_410474326_9MjFgbFkAsg1CR4gMhJ8rZDcKNEsS7yR.jpg',
            //'https://t3.ftcdn.net/jpg/04/11/88/80/240_F_411888052_pw3RyeOcQRDzP4roU115q64q14RAsiwY.jpg',
          ),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 0,
        blur: 6,
        alignment: Alignment.bottomCenter,
        border: 0.0,
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
          Color(0xFFffffff).withOpacity(0.5),
            Color((0xFFFFFFFF)).withOpacity(0.5),
          ],
        ),
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.6),
              Colors.white,
            ],
            stops: [
              0.1,
              1,
            ]),
        child: Container()
      ),
    );
  }
}