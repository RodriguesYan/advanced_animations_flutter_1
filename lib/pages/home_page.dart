import 'package:animation_2_chained/utils/path_extension.dart';
import 'package:animation_2_chained/widgets/half_circle_clipper.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: const HalfCircleClipper(side: CircleSide.left),
              child: Container(
                color: const Color(0xff0057b7),
                width: 100,
                height: 100,
              ),
            ),
            ClipPath(
              clipper: const HalfCircleClipper(side: CircleSide.right),
              child: Container(
                color: const Color(0xffffd700),
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
