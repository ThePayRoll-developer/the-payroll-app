import 'package:payroll_app/src/features/employee/model/employee.dart';

class Salary {
  int? id;
  Employee? employee;
  double? empBonus;
  double? empAdvance;
  double? amount;
  double? totalSalary;
  String? date;
  double? totalAmount;

  Salary(
      {this.id,
        this.employee,
        this.empBonus,
        this.empAdvance,
        this.amount,
        this.totalSalary,
        this.date,
        this.totalAmount});

  Salary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    empBonus = json['empBonus'];
    empAdvance = json['empAdvance'];
    amount = json['amount'];
    totalSalary = json['totalSalary'];
    date = json['date'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['empBonus'] = this.empBonus;
    data['empAdvance'] = this.empAdvance;
    data['amount'] = this.amount;
    data['totalSalary'] = this.totalSalary;
    data['date'] = this.date;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}