import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(
          () {
            if (themeConfig == AppThemeConfig.light()) {
              themeConfig = AppThemeConfig.dark();
            } else {
              themeConfig = AppThemeConfig.light();
            }
          },
        );
      },
      icon: Icon(
        themeConfig == AppThemeConfig.light()
            ? CupertinoIcons.sun_min
            : CupertinoIcons.moon,
      ),
    );
  }
}
