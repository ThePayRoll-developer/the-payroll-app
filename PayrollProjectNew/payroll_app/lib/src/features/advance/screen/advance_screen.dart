import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:payroll_app/src/features/advance/controller/advance_controller.dart';
import 'package:payroll_app/src/features/advance/model/advance.dart';
import 'package:payroll_app/src/features/advance/screen/advace_form.dart';

import '../../../repository/authentication/authentication_repository.dart';

class AdvanceScreen extends StatefulWidget {
  const AdvanceScreen({super.key});

  @override
  State<AdvanceScreen> createState() => _AdvanceScreenState();
}

class _AdvanceScreenState extends State<AdvanceScreen> {

  final AdvanceController _service = AdvanceController();


  final _authRepo = Get.put(AuthenticationRepository());

  late Future<List<Advance>> advances;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advances = _service.getEmployeeAdvance(_authRepo.getUserEmail());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Recent Salary's Advances List",
            style: Theme.of(context).textTheme.headlineMedium),
      ),

      body:Center(
        child:
        FutureBuilder<List<Advance>>(
          future: advances,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final advancesList = snapshot.data!;
                return buildSalaryAdvances(advancesList);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=> AdvanceForm());
        },
        tooltip: "New Advance Request",
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildSalaryAdvances(List<Advance> advance) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50.0),

      child: ListView.builder(
        itemCount: advance.length,
        itemBuilder: (context, index) {
          final data = advance[index];
          if(kDebugMode){
            print(data);
          }
          return ListTile(
            title:
            // Text(day.checkIn!),
            Text("Employee: ${data.employee?.name!}"),
            subtitle: Text("Advance Date: ${f.format(DateTime.parse(data.date!))}"
                "\nAdvance Reason: ${data.reason}"
                "\nAdvance Amount: ${data.amount} "),
            contentPadding:const EdgeInsets.all(10.0),
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
