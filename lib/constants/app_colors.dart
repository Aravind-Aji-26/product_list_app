// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

abstract class Palette {
  static const Color primary = Color(0XFF00C2F3);
  static const Color primaryLight = Color(0xFFEBF9FF);
  static const Color primaryDark = Color(0xFF0094FF);
  static const Color scaffoldBackgroundColor = Color(0xffFFFFFF);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color green = Color(0xFF4CAF50);
  static const Color red = Color(0xFFE61B23);
  static const Color grey = Color(0xff969696);

  static const Color blackTextColor = Color(0xFF01031C);
  static const Color greyTextColor = Color(0xFF615C5C);
  static const Color greyTextColorLight = Color(0xFF879DA6);
  static const Color greenTextColor = Color(0xFF00AB4E);

  static const Color yellowStatusBg = Color(0xFFFEFFE5);
  static const Color yellowStatusText = Color(0xFFFFBC0F);
  static const Color blueStatusBg = Color(0xFFEAFCFF);
  static const Color blueStatusText = Color(0xFF1ABBB9);
  static const Color greenStatusText = Color(0xFF18AB56);
  static const Color greenStatusBg = Color(0xFFF0FFF7);
  static const Color redStatusBg = Color(0xFFFFF0F0);
  static const Color redStatusText = Color(0xFFEB5757);
  static const Color billList = Color(0xFFEFF4FF);
  static const Color docTextFieldFillColor = Color(0xFFF4F7FE);

  static const primaryGradient = LinearGradient(
    begin: Alignment(0.69, -0.73),
    end: Alignment(-0.69, 0.73),
    colors: [Color(0XFF00C2F3), Color(0XFF00C2F3)],
  );
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) {
  return max(0, min((value + ((255 - value) * factor)).round(), 255));
}

Color tintColor(Color color, double factor) {
  return Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1,
  );
}

int shadeValue(int value, double factor) {
  return max(0, min(value - (value * factor).round(), 255));
}

Color shadeColor(Color color, double factor) {
  return Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1,
  );
}
