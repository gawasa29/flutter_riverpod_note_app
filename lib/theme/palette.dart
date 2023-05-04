import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_colors.dart';

final themeNotifierProvider = StateProvider((ref) {
  return Palette.darkModeAppTheme;
});

class Palette {
  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: ThemeColors.lightTextColor),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ThemeColors.buttonColor),
    textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(foregroundColor: ThemeColors.lightTextColor)),
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: ThemeColors.orange)),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: ThemeColors.orange),
    scaffoldBackgroundColor: ThemeColors.scaffoldBackground,
    brightness: Brightness.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(100, 50),
            backgroundColor: ThemeColors.buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)))),
  );
}
