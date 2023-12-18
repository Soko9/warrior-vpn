import "package:flutter/material.dart";
import "package:warrior_vpn/utils/colors.dart";

class THEMES {
  static const String _font = "Hermit";
  static const Color _primary = COLORS.primary;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.light,
    ),
    fontFamily: _font,
    scaffoldBackgroundColor: COLORS.lightBackground,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.dark,
    ),
    fontFamily: _font,
    scaffoldBackgroundColor: COLORS.darkBackground,
  );
}
