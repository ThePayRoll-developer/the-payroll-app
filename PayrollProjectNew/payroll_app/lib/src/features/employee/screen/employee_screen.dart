

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payroll_app/src/features/core/controllers/profile_controller/profile_controller.dart';
import 'package:payroll_app/src/features/employee/controller/employee_controller.dart';
import 'package:payroll_app/src/features/employee/model/employee.dart';
import 'package:payroll_app/src/repository/authentication/authentication_repository.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  final EmployeeController _service = EmployeeController();
  // final AuthenticationRepository _authRepo = AuthenticationRepository();
  final _authRepo = Get.put(AuthenticationRepository());

  late Future<Employee> emp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emp = _service.fetchEmployee(_authRepo.getUserEmail());
  }
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProfileController());
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: FutureBuilder(
            future: emp,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Employee emp = snapshot.data as Employee;
                  return SizedBox(
                    width: 300,
                    height: 300,
                    child: Column(
                      children: [
                        Text(emp.name!,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          emp.gender!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          emp.joiningDate!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          emp.email!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong."),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
