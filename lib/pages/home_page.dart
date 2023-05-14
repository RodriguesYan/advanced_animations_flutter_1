import 'package:animation_2_chained/utils/path_extension.dart';
import 'package:animation_2_chained/widgets/half_circle_clipper.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController counterClockwiseRotationController;
  late Animation<double> counterClockwiseRotationAnimation;

  late AnimationController flipController;
  late Animation<double> flipAnimation;

  @override
  void initState() {
    super.initState();

    counterClockwiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    counterClockwiseRotationAnimation = Tween<double>(
      begin: 0,
      //we want to animate the circle counter clockwise. So pi / 2 is 90 degrees and it negative is going to animate to the left
      end: -(pi / 2),
    ).animate(
      CurvedAnimation(
        parent: counterClockwiseRotationController,
        curve: Curves.bounceOut,
      ),
    );

    flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: flipController,
        curve: Curves.bounceOut,
      ),
    );

    counterClockwiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        flipAnimation = Tween<double>(
          begin: flipAnimation.value,
          end: flipAnimation.value + pi,
        ).animate(
          CurvedAnimation(
            parent: flipController,
            curve: Curves.bounceOut,
          ),
        );

        flipController
          ..reset()
          ..forward();
      }
    });

    flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        counterClockwiseRotationAnimation = Tween<double>(
          begin: counterClockwiseRotationAnimation.value,
          //we want to animate the circle counter clockwise. So pi / 2 is 90 degrees and it negative is going to animate to the left
          end: counterClockwiseRotationAnimation.value + -(pi / 2),
        ).animate(
          CurvedAnimation(
            parent: counterClockwiseRotationController,
            curve: Curves.bounceOut,
          ),
        );

        counterClockwiseRotationController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    counterClockwiseRotationController.dispose();
    flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    counterClockwiseRotationController
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: counterClockwiseRotationController,
          builder: (BuildContext context, Widget? child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateZ(counterClockwiseRotationAnimation.value),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  builder: (context, child) => Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()..rotateY(flipAnimation.value),
                    child: ClipPath(
                      clipper: const HalfCircleClipper(side: CircleSide.left),
                      child: Container(
                        color: const Color(0xff0057b7),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  animation: flipController,
                ),
                AnimatedBuilder(
                  builder: (context, child) => Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()..rotateY(flipAnimation.value),
                    child: ClipPath(
                      clipper: const HalfCircleClipper(side: CircleSide.right),
                      child: Container(
                        color: const Color(0xffffd700),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  animation: flipAnimation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
