import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:payroll_app/src/features/leave/controller/leave_controller.dart';
import 'package:payroll_app/src/features/leave/model/leave.dart';
import 'package:payroll_app/src/features/leave/screen/leave_form.dart';

import '../../../repository/authentication/authentication_repository.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  final LeaveController _service = LeaveController();


  final _authRepo = Get.put(AuthenticationRepository());

  late Future<List<Leave>> leaves;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leaves = _service.getEmployeeLeave(_authRepo.getUserEmail());
  }
  // check if leave granted
  String isGranted(bool value){
    if(value){
      return "Granted.";
    }else{
      return "Pending.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Recent Leave List",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body:Center(
        child:
        FutureBuilder<List<Leave>>(
          future: leaves,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final leaveList = snapshot.data!;
                return buildLeave(leaveList);
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
          Get.to(()=> LeaveForm());
        },
        tooltip: "New Leave Request",
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildLeave(List<Leave> leave) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50.0),

      child: ListView.builder(
        itemCount: leave.length,
        itemBuilder: (context, index) {
          final data = leave[index];
          if(kDebugMode){
            print(data);
          }
          return ListTile(
            title:
            // Text(day.checkIn!),
            Text("Employee: ${data.employee?.name!}"),
            subtitle: Text("Leave Date: ${f.format(DateTime.parse(data.leaveDate!).toLocal())} \nLeave Reason: ${data.leaveReason}\nLeave Grant: ${isGranted(data.grant!)}" ),

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
