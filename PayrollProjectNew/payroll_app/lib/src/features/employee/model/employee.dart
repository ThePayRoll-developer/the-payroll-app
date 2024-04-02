class Employee {
  int? id;
  String? name;
  String? joiningDate;
  String? email;
  String? gender;
  String? contact;
  String? salary;
  Department? department;

  Employee(
      {this.id,
        this.name,
        this.joiningDate,
        this.email,
        this.gender,
        this.contact,
        this.salary,
        this.department});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    joiningDate = json['joiningDate'];
    email = json['email'];
    gender = json['gender'];
    contact = json['contact'];
    salary = json['salary'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['joiningDate'] = this.joiningDate;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['contact'] = this.contact;
    data['salary'] = this.salary;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    return data;
  }
}

class Department {
  int? id;
  String? deptName;

  Department({this.id, this.deptName});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deptName = json['deptName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deptName'] = this.deptName;
    return data;
  }
}
