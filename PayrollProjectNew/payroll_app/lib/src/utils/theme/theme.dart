import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payroll_app/src/utils/theme/widget_theme/elevated_button_theme.dart';
import 'package:payroll_app/src/utils/theme/widget_theme/floating_button_theme.dart';
import 'package:payroll_app/src/utils/theme/widget_theme/outlined_button_theme.dart';
import 'package:payroll_app/src/utils/theme/widget_theme/text_formfield_theme.dart';
import 'package:payroll_app/src/utils/theme/widget_theme/text_theme.dart';

class TAppTheme{
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    floatingActionButtonTheme: TFloatingActionButtonTheme.FloatingActionButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    floatingActionButtonTheme: TFloatingActionButtonTheme.FloatingActionButtonTheme,
  );
}

