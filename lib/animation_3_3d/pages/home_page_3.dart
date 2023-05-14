import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

const double widthAndHeight = 100;

class _HomePage3State extends State<HomePage3> with TickerProviderStateMixin {
  late AnimationController xcontroller;
  late AnimationController ycontroller;
  late AnimationController zcontroller;
  late Tween<double> animation;

  @override
  void initState() {
    super.initState();

    xcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    ycontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    zcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    xcontroller.dispose();
    ycontroller.dispose();
    zcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    xcontroller
      ..reset()
      ..repeat();

    ycontroller
      ..reset()
      ..repeat();

    zcontroller
      ..reset()
      ..repeat();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: widthAndHeight,
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: Listenable.merge([
                xcontroller,
                ycontroller,
                zcontroller,
              ]),
              builder: (BuildContext context, Widget? child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(animation.evaluate(xcontroller))
                  ..rotateY(animation.evaluate(ycontroller))
                  ..rotateZ(animation.evaluate(zcontroller)),
                child: Stack(
                  children: [
                    //back
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(Vector3(0, 0, -widthAndHeight)),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.purple,
                      ),
                    ),
                    //right
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.red,
                      ),
                    ),
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.yellow,
                      ),
                    ),
                    //front
                    Container(
                      width: widthAndHeight,
                      height: widthAndHeight,
                      color: Colors.green,
                    ),
                    //top
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.blue,
                      ),
                    ),
                    //bottom
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX(pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
