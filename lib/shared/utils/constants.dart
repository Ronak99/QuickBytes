import 'package:flutter/material.dart';

class ColorConstants {
  static Color themeColor = Colors.blue;
  static Color primaryLight = Colors.white;
  static Color primaryLightContrast = Colors.black;
  static Color primaryDark = const Color(0xff151313);
  static Color primaryDarkContrast = Colors.white;
  static Color newsCardDark = const Color(0xff191818);
  static Color primaryDarkestDark = const Color(0xff0B0B0B);
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

class AssetConstants {
  static const back = "assets/images/back.svg";
  static const articleCardBackground = "assets/images/article_bg_pattern.png";
  static const share = "assets/images/share.svg";
  static const next = "assets/images/next.svg";
  static const rating = "assets/images/rating.svg";
  static const feedback = "assets/images/feedback.svg";
  static const preference = "assets/images/preference.svg";
  static const setting = "assets/images/setting.svg";
  static const checkmark = "assets/lottie/checkmark.lottie";
  static const logoForeground = "assets/images/logo_foreground.svg";
}

class AppConfig {
  static const version = '1.0.2';
  static const versionCode = '3';
  static const patch = '3';
  static const name = 'QuickBytes';
}
