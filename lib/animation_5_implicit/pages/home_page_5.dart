import 'package:flutter/material.dart';

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> {
  double height = 50;
  bool bigImageIsOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            height: height,
            width: height,
            curve: Curves.bounceOut,
            duration: const Duration(milliseconds: 350),
            child: Image.asset('assets/images/wallpaper2.png'),
          ),
          TextButton(
            onPressed: () {
              bigImageIsOn = !bigImageIsOn;
              height = bigImageIsOn ? 350 : 50;
              setState(() {});
            },
            child: Text(bigImageIsOn ? 'zoom out' : 'zoom in'),
          ),
        ],
      ),
    );
  }
}
