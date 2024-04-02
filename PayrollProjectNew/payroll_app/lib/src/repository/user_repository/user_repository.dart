import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_app/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get intance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection("users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace){
      Get.snackbar("Error", "Something went wrong. Try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
          print(error.toString());
    });
  }


  Future<UserModel> getUserDetails(String email) async{
    final snapshot = await _db.collection("users").where("Email", isEqualTo: email).get();
    final userModel = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userModel;
  }
}
