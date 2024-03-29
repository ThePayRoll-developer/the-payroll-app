

import 'package:flutter/material.dart';
import 'package:payroll_app/src/constants/colors.dart';
import 'package:payroll_app/src/constants/sizes.dart';

class TElevatedButtonTheme{
  TElevatedButtonTheme._();


  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: tWhiteColor,
        backgroundColor: tSecondaryColor,
        side: BorderSide(color: tSecondaryColor),
        padding: EdgeInsets.symmetric(vertical: tButtonHeight)
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: tSecondaryColor,
        backgroundColor: tWhiteColor,
        side: BorderSide(color: tSecondaryColor),
        padding: EdgeInsets.symmetric(vertical: tButtonHeight)
    ),
  );

}