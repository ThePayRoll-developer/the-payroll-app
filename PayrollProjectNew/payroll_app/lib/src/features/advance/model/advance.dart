import 'package:payroll_app/src/features/employee/model/employee.dart';

class Advance {
  int? id;
  Employee? employee;
  double? amount;
  String? reason;
  String? date;

  Advance({this.id, this.employee, this.amount, this.reason, this.date});

  Advance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    amount = json['amount'];
    reason = json['reason'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['amount'] = this.amount;
    data['reason'] = this.reason;
    data['date'] = this.date;
    return data;
  }
}