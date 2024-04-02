

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_app/src/features/authentication/models/user_model.dart';
import 'package:payroll_app/src/features/core/screens/dashboard/dashboard.dart';
import 'package:payroll_app/src/repository/authentication/authentication_repository.dart';
import 'package:payroll_app/src/repository/user_repository/user_repository.dart';

// import '../../../repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  // user repo to set data in user model
  final userRepo = Get.put(UserRepository());


  //Call this Function from Design & it will do the rest
  void registerUser(String email, String password) {

    String? error = AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password) as String?;
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    registerUser(user.email.toString(), user.password.toString());
    Get.to(()=> const Dashboard());
  }

}