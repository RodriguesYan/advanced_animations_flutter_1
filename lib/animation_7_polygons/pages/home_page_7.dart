import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class HomePage7 extends StatefulWidget {
  const HomePage7({super.key});

  @override
  State<HomePage7> createState() => _HomePage7State();
}

class Polygon extends CustomPainter {
  final int sides;

  Polygon({required this.sides});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      //draw the thing without filling it inside. To fill, use .fill
      ..style = PaintingStyle.stroke
      //the shape corner between the lines
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final path = Path();

    final center = Offset(size.width / 2, size.height / 2);
    //pi == 180 degress
    //it gets the value of each angle to be drawed
    final angle = (2 * pi) / sides;
    //creates an index for each side provided in constructor and multiplies it by the angle
    //if it is 3, so the angle is 120. The first index gets 0 (120 * 0 == 0), the second 120, the third 240
    final angles = List.generate(sides, (index) => index * angle);
    final radius = size.width / 2;

    //move initial draw point to right center of the component that is zero
    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }

    //drazw the last line from the final angle to the initial angle
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}

class _HomePage7State extends State<HomePage7> with TickerProviderStateMixin {
  late AnimationController sidesController;
  late Animation<int> sidesAnimation;

  late AnimationController radiusController;
  late Animation<double> radiusAnimation;

  late AnimationController rotationController;
  late Animation<double> rotationAnimation;

  @override
  void initState() {
    super.initState();

    sidesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    radiusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    sidesAnimation = IntTween(
      begin: 3,
      end: 10,
    ).animate(sidesController);

    radiusAnimation = Tween(
      begin: 20.0,
      end: 400.0,
    )
        .chain(
          CurveTween(curve: Curves.bounceInOut),
        )
        .animate(radiusController);

    rotationAnimation = Tween(
      begin: 0.0,
      end: 2 * pi,
    )
        .chain(
          CurveTween(curve: Curves.easeInOut),
        )
        .animate(rotationController);
  }

  @override
  void dispose() {
    sidesController.dispose();
    radiusController.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    sidesController.repeat(reverse: true);
    radiusController.repeat(reverse: true);
    rotationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            sidesController,
            radiusController,
            rotationController,
          ]),
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateX(rotationAnimation.value)
              ..rotateY(rotationAnimation.value)
              ..rotateZ(rotationAnimation.value),
            child: CustomPaint(
              painter: Polygon(sides: sidesAnimation.value),
              child: SizedBox(
                width: radiusAnimation.value,
                height: radiusAnimation.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
