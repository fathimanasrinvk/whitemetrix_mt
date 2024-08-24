import 'dart:async';
import 'package:flutter/material.dart';

import '../../signup_screen/view/signup_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => RegistrationScreen())
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash_pic.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 270,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/HerMac__2_-removebg-preview.png',
            ),
          ),
        ],
      ),
    );
  }
}
