import 'package:payroll_app/src/features/employee/model/employee.dart';

class Bonus {
  int? id;
  Employee? employee;
  int? amount;
  String? bonusDate;

  Bonus({this.id, this.employee, this.amount, this.bonusDate});

  Bonus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    amount = json['amount'];
    bonusDate = json['bonusDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['amount'] = this.amount;
    data['bonusDate'] = this.bonusDate;
    return data;
  }
}