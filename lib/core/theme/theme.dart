import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

abstract class AppFontFamilies {
  static const montserrat = 'Montserrat';
}

final appThemeData = ThemeData(
    fontFamily: AppFontFamilies.montserrat,
    scaffoldBackgroundColor: AppColors.primary);
