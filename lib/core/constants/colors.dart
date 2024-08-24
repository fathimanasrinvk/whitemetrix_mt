import 'package:flutter/material.dart';

class ColorTheme {
  static Color maincolor = Color(0xff643E0B);
  static Color secondarycolor = Color(0xffFBF0E1);
  static Color white = Color(0xFFffffff);
  static Color grey = const Color(0xFF989898);
  static Color black = const Color.fromARGB(255, 0, 0, 0);
  static Color red = const Color.fromARGB(255, 209, 0, 0);
  static Color green = const Color(0xFF00c254);
}

double constantsize(BuildContext context) {
  return MediaQuery.of(context).size.width * (1 / 411);
}
