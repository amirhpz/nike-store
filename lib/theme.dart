import 'package:flutter/cupertino.dart';

LightThemeColors themeData = LightThemeColors();

class LightThemeColors {
  static const primaryColor = Color.fromARGB(255, 17, 98, 186);
  static const secondaryColor = Color(0xff262a35);
  static const primaryTextColor = Color(0xff262A35);
  static const secondaryTextColor = Color(0xffb3b6be);
  static const surfaceVarientColor = Color(0xfff5f5f5);
}

class DarkThemeColors {
  static const primaryColor = Color.fromARGB(255, 17, 98, 186);
  static const secondaryColor = Color.fromARGB(255, 255, 255, 255);
  static const primaryTextColor = Color.fromARGB(255, 210, 210, 210);
  static const secondaryTextColor = Color.fromARGB(255, 29, 29, 29);
  static const surfaceVarientColor = Color(0xfff5f5f5);
}

AppThemeConfig themeConfig = AppThemeConfig.light();

class AppThemeConfig {
  final Color primaryColor;
  final Color secondaryColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceVarientColor;
  AppThemeConfig.light()
      : primaryColor = const Color.fromARGB(255, 17, 98, 186),
        secondaryColor = const Color(0xff262a35),
        primaryTextColor = const Color(0xff262A35),
        secondaryTextColor = const Color(0xffb3b6be),
        surfaceVarientColor = const Color(0xfff5f5f5);

  AppThemeConfig.dark()
      : primaryColor = const Color.fromARGB(255, 17, 98, 186),
        secondaryColor = const Color(0xff262a35),
        primaryTextColor = const Color(0xfff5f5f5),
        secondaryTextColor = const Color(0xffb3b6be),
        surfaceVarientColor = const Color(0xff262A35);
}
