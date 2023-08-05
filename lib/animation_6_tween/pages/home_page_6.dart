import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage6 extends StatefulWidget {
  const HomePage6({super.key});

  @override
  State<HomePage6> createState() => _HomePage6State();
}

/*
  A R G B = 32 bits
    A = Alpha (0 - 255) - 8 bits
    R = Red (0 - 255) - 8 bits
    G = Green (0 - 255) - 8 bits
    B = Blue (0 - 255) - 8 bits
*/

Color getRandomColor() => Color(
      0xFF000000 + math.Random().nextInt(0x00FFFFFF),
    );

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();
  @override
  Path getClip(Size size) {
    var path = Path();

    final rect = Rect.fromCircle(
      //calculation to get the center of the component
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    path.addOval(rect);

    return path;
  }

  //if the component changes of size, for example, we had to do something do reclip
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class _HomePage6State extends State<HomePage6> {
  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: const CircleClipper(),
          child: TweenAnimationBuilder(
            builder: (BuildContext context, Color? color, Widget? child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color!,
                  BlendMode.srcATop,
                ),
                child: child!,
              );
            },
            duration: const Duration(seconds: 1),
            tween: ColorTween(
              begin: getRandomColor(),
              end: _color,
            ),
            onEnd: () {
              setState(() {
                _color = getRandomColor();
              });
            },
            child: Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}
