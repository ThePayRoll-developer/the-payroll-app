import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_app/src/features/core/screens/dashboard/dashboard.dart';
import 'package:payroll_app/src/repository/authentication/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  //Call this Function from Design & it will do the rest
  void singInUser(String email, String password) {
    String? error = AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password) as String;
    // Get.to(() => Dashboard());
    if (error != null) {
      Get.showSnackbar(
        GetSnackBar(
          message: error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
        ),
      );
    }
  }
}
