


import 'dart:convert';

import 'package:get/get.dart';

import '../model/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeController extends GetxController{
  static EmployeeController get instance => Get.find();


  static const String baseUrl="http://localhost:8086/api/employee";



  Future<Employee> fetchEmployee(String email) async {
    final response = await http.get(Uri.parse("$baseUrl/${email}"));
    if(response.statusCode == 200){
      // dynamic jsonResponse = json.decode(response.body);
      // return jsonResponse.map((e)=> Employee.fromJson(e).);
      return Employee.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }else {
      throw Exception("Failed to load data.");
    }
  }
}