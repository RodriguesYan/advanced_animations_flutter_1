import 'package:flutter/material.dart';

import 'animation_3_3d/pages/home_page_3.dart';
import 'animation_4_hero/pages/home_page_4.dart';
import 'animation_5_implicit/pages/home_page_5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage5(),
    );
  }
}
