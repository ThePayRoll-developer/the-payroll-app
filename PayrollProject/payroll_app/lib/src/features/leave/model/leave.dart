import 'package:payroll_app/src/features/employee/model/employee.dart';

class Leave {
  int? id;
  Employee? employee;
  String? contact;
  String? leaveDate;
  String? leaveReason;
  bool? grant;

  Leave(
      {this.id,
        this.employee,
        this.contact,
        this.leaveDate,
        this.leaveReason,
        this.grant});

  Leave.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    contact = json['contact'];
    leaveDate = json['leaveDate'];
    leaveReason = json['leaveReason'];
    grant = json['grant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['contact'] = this.contact;
    data['leaveDate'] = this.leaveDate;
    data['leaveReason'] = this.leaveReason;
    data['grant'] = this.grant;
    return data;
  }
}