import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll_app/src/constants/image_strings.dart';
import 'package:payroll_app/src/constants/sizes.dart';
import 'package:payroll_app/src/constants/text_strings.dart';
import 'package:payroll_app/src/features/authentication/screens/signup/form_header_widget.dart';
import 'package:payroll_app/src/features/authentication/screens/signup/signup_footer_widget.dart';
import 'package:payroll_app/src/features/authentication/screens/signup/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: const [
                FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                  imageHeight: 0.15,
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}