

import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payroll_app/src/features/leave/model/leave.dart';
import 'package:http/http.dart' as http;

import '../../../repository/authentication/authentication_repository.dart';
import '../../employee/controller/employee_controller.dart';

class LeaveController{
  static const String baseUrl="http://localhost:8086/api/leave";


  final _authRepo = Get.put(AuthenticationRepository());
  final EmployeeController _empservice = EmployeeController();


  TextEditingController leaveDate = TextEditingController();
  TextEditingController leaveReason = TextEditingController();
  TextEditingController contact = TextEditingController();

  Future<List<Leave>> getEmployeeLeave(String email) async {
    final response = await http.get(Uri.parse("$baseUrl/${email}"));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Leave.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data.");
    }
  }

  // crate new leave request----------
  Future<Leave> createLeave(Leave leave) async {
    // final emp = await _empservice.fetchEmployee(_authRepo.getUserEmail());
    final response = await http.post(
      Uri.parse('$baseUrl/flutter'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(leave.toJson()
      ),
    );
    if (response.statusCode == 200) {
      return Leave.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falied to create task");
    }
  }


}