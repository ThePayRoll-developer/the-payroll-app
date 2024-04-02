import 'dart:convert';

import 'package:payroll_app/src/features/attendance/model/attendance.dart';
import 'package:payroll_app/src/features/core/controllers/profile_controller/profile_controller.dart';
import 'package:payroll_app/src/features/employee/controller/employee_controller.dart';
import 'package:payroll_app/src/features/employee/model/employee.dart';
import 'package:http/http.dart' as http;

class AttendanceController {
  static const String baseUrl = "http://localhost:8086/api/attendance";
  static const String postBaseUrl = "http://localhost:8086/api/attendance/flutter";

//   EmployeeController empController = EmployeeController();
//   ProfileController profileController = ProfileController();
//
//   Future<Employee> getEmployeeDetails() async {
//     return await profileController.getEmployeeData();
// }

  Future<List<Attendance>> getEmployeeDays(String email) async {
    final response = await http.get(Uri.parse("$baseUrl/${email}"));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Attendance.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data.");
    }
  }
// latest attendance
  Future<List<Attendance>> getEmployeeLatestDays(String email) async {
    final response = await http.get(Uri.parse("$baseUrl/latest/${email}"));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Attendance.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data.");
    }
  }

  // crate new Attendance----------
  Future<Attendance> createAttendance(Attendance attendance) async {
    final response = await http.post(
      Uri.parse(postBaseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(attendance.toJson()),
    );
    if (response.statusCode == 200) {
      return Attendance.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to create Attendance");
    }
  }
}
