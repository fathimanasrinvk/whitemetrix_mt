import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whitematrix_mt/core/constants/colors.dart';
import 'package:whitematrix_mt/presentation/product_screen/view/product_screen.dart';
void main(){
  runApp(MaterialApp(home: Splash(),));
}


class Splash extends StatefulWidget {
  const Splash({Key? key }):super(key:key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen())
          );
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      Positioned.fill(
      child: Image.asset(
        'assets/images/splash_pic.png',
        fit: BoxFit.fill, // Adjust how the image should be resized to cover the screen
      ),
    ),
   ] ));
  }
}
