import 'package:flutter/material.dart';
import 'package:quickbytes_app/shared/utils/constants.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        // scaffoldBackgroundColor: _lightTheme,
        cardColor: ColorConstants.newsCardLight,
        iconTheme: ThemeConstants.primaryIcon.copyWith(
          color: ColorConstants.primaryLightContrast.withOpacity(.7),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstants.themeColor,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyleConstants.displayLarge.copyWith(
            color: ColorConstants.primaryLightContrast,
          ),
          displayMedium: TextStyleConstants.displayMedium.copyWith(
            color: ColorConstants.primaryLightContrast.withOpacity(.7),
          ),
          displaySmall: TextStyleConstants.displaySmall.copyWith(
            color: ColorConstants.primaryLightContrast.withOpacity(.7),
          ),
        ),
      );
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        cardColor: ColorConstants.newsCardDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstants.themeColor,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConstants.primaryDarkestDark,
          elevation: 0,
          centerTitle: true,
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey[800]!,
              width: 0.5,
            ),
          ),
        ),
        scaffoldBackgroundColor: ColorConstants.primaryDarkestDark,
        iconTheme: ThemeConstants.primaryIcon.copyWith(
          color: ColorConstants.primaryDarkContrast.withOpacity(.7),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyleConstants.displayLarge.copyWith(
            color: ColorConstants.primaryDarkContrast,
          ),
          displayMedium: TextStyleConstants.displayMedium.copyWith(
            color: ColorConstants.primaryDarkContrast.withOpacity(.7),
          ),
          displaySmall: TextStyleConstants.displaySmall.copyWith(
            color: ColorConstants.primaryDarkContrast.withOpacity(.7),
          ),
        ),
      );
}
