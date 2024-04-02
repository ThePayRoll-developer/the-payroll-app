
import 'dart:convert';

import 'package:payroll_app/src/features/salary/model/salary.dart';
import 'package:http/http.dart' as http;
class SalaryController{
  static const String baseUrl="http://localhost:8086/api/salaries/emp";

  Future<List<Salary>> getEmployeeSalary(String email) async {
    final response = await http.get(Uri.parse("$baseUrl/${email}"));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Salary.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data.");
    }
  }

}