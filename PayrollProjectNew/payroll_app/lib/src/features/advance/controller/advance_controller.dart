
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_app/src/features/advance/model/advance.dart';
class AdvanceController{


  static const String baseUrl="http://localhost:8086/api/advance";


  TextEditingController amount = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController date = TextEditingController();

  Future<List<Advance>> getEmployeeAdvance(String email) async {
    final response = await http.get(Uri.parse("$baseUrl/${email}"));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Advance.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data.");
    }
  }
  // crate new advance request----------
  Future<Advance> createAdvance(Advance advance) async {

    final response = await http.post(
      Uri.parse('$baseUrl/flutter'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(advance.toJson()
      ),
    );
    if (response.statusCode == 200) {
      return Advance.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falied to create task");
    }
  }
}