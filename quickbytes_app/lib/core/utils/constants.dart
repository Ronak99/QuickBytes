import 'package:flutter/material.dart';

class ColorConstants {
  static Color themeColor = Colors.blue;
  static Color primaryLight = Colors.white;
  static Color primaryLightContrast = Colors.black;
  static Color primaryDark = Colors.black;
  static Color primaryDarkContrast = Colors.white;
  static Color newsCardDark = const Color(0xff191818);
  static Color newsCardLight = const Color.fromARGB(255, 245, 243, 243);
}

class ThemeConstants {
  static IconThemeData primaryIcon = const IconThemeData(size: 30);
}

class TextStyleConstants {
  static TextStyle displayLarge = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.2,
  );

  static TextStyle displayMedium = const TextStyle(
    fontSize: 18,
    height: 1.5,
    fontWeight: FontWeight.w300,
  );

  static TextStyle displaySmall = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
}
