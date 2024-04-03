

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll_app/src/constants/image_strings.dart';
import 'package:payroll_app/src/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section 01
        Image(
          image: AssetImage(tWelcomeScreenImage),
          height: size.height * 0.3,
        ),
        Text(
          tLoginTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          tLoginSubTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        // Section 01 --end
        // Section 02--- Form

        // Section 02--- Form -- end
      ],
    );
  }
}