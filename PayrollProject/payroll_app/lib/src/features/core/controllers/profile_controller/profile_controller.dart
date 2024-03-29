
import 'dart:html';

import 'package:get/get.dart';
import 'package:payroll_app/src/features/employee/controller/employee_controller.dart';
import 'package:payroll_app/src/repository/authentication/authentication_repository.dart';
import 'package:payroll_app/src/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController{
 static ProfileController get instance => Get.find();


 final _authRepo = Get.put(AuthenticationRepository());
 final _userRepo = Get.put(UserRepository());
 final _empRepo = Get.put(EmployeeController());

 getUserData(){
   // get user email from firebase auth
   final email = _authRepo.firebaseUser.value?.email;
   if(email != null){
    return _userRepo.getUserDetails(email);
   }else{
    Get.snackbar("Error", "Login to continue.");
   }
 }

 getEmployeeData(){
   final email = _authRepo.firebaseUser.value?.email;
   final email3 = _authRepo.getUserEmail();
   if(email != null){
     return _empRepo.fetchEmployee(email);
   }else{
     Get.snackbar("Error", "Login to continue.");
   }
 }
}