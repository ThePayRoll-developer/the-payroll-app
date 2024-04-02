import 'package:intl/intl.dart';
import 'package:payroll_app/src/features/employee/model/employee.dart';

class Attendance {
  int? id;
  Employee? employee;
  String? checkIn;
  String? checkOut;

  Attendance({this.id, this.employee, this.checkIn, this.checkOut});

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    return data;
  }
}