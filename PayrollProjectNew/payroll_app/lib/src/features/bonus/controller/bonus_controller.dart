


import 'dart:convert';

import 'package:payroll_app/src/features/bonus/model/bonus.dart';
import 'package:http/http.dart' as http;

class BonusController{
  static const String baseUrl="http://localhost:8086/api/bonus";

  Future<List<Bonus>> getEmployeeBonus(String email) async {
    final response = await http.get(Uri.parse("$baseUrl/${email}"));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Bonus.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data.");
    }
  }




}
