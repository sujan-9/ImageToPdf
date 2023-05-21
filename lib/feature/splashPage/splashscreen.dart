import 'dart:async';

import 'package:flutter/material.dart';


import '../bottombar/bootombar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Timer(const Duration(seconds: 2), () {
      // After 3 seconds, navigate to the main screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) =>const BottomBar()),
      );
    });

    return const Scaffold(
      body: Center(
        child: Text(
          'Image To PDF',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      )

    );
  }
}