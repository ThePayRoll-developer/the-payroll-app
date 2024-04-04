import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:payroll_app/src/features/salary/controller/salary_controller.dart';
import 'package:payroll_app/src/features/salary/model/salary.dart';

import '../../../repository/authentication/authentication_repository.dart';

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {


  final SalaryController _service = SalaryController();


  final _authRepo = Get.put(AuthenticationRepository());

  late Future<List<Salary>> salaries;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    salaries = _service.getEmployeeSalary(_authRepo.getUserEmail());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Recent Salary List",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body:Center(
        child:
        FutureBuilder<List<Salary>>(
          future: salaries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final salaryList = snapshot.data!;
                return buildSalary(salaryList);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
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
    );
  }

  Widget buildSalary(List<Salary> money) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50.0),

      child: ListView.builder(
        itemCount: money.length,
        itemBuilder: (context, index) {
          final data = money[index];
          if(kDebugMode){
            print(data);
          }
          return ListTile(
            title:
            // Text(day.checkIn!),
            Text("Employee: ${data.employee?.name!}"),
            subtitle: Text("Salary Date: ${f.format(DateTime.parse(data.date!).toLocal())} "
                "\nBonus: ${data.empBonus}\nSalary Advance: ${data.empAdvance}\nSalary Amount: ${data.totalSalary}"),

            contentPadding:const EdgeInsets.all(10.0),
            // subtitle: Text(f.format(DateTime.parse(day.checkOut!))),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {
                }, icon:const Icon(Icons.edit)),
                IconButton(onPressed: () async{
                }, icon:const Icon(Icons.delete)),
              ],
            ),
          );
        },
      ),
    );
  }
}
