import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:payroll_app/src/features/attendance/controller/attendance_controller.dart';
import 'package:payroll_app/src/features/attendance/model/attendance.dart';
import 'package:payroll_app/src/features/attendance/screen/attendance_form.dart';

import '../../../constants/sizes.dart';
import '../../../repository/authentication/authentication_repository.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceController _service = AttendanceController();


  final _authRepo = Get.put(AuthenticationRepository());

  late Future<List<Attendance>> days;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    days = _service.getEmployeeDays(_authRepo.getUserEmail());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Recent Attendance List",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Center(
        child: FutureBuilder<List<Attendance>>(
          future: days,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final attend = snapshot.data!;
                return buildAttendance(attend);
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
          Get.to(()=> AttendanceForm());
        },
        tooltip: "New Attendance Request",
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget buildAttendance(List<Attendance> attendance) {
    final f = DateFormat('yyyy-MM-dd hh:mm:ss a');
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50.0),

      child: ListView.builder(
        itemCount: attendance.length,
        itemBuilder: (context, index) {
          final day = attendance[index];
          if(kDebugMode){
            print(day);
          }
          return ListTile(
            title:
            // Text(day.checkIn!),
            Text("Employee: ${day.employee?.name!}"),
            subtitle: Text("Check In: ${f.format(DateTime.parse(day.checkIn!).toLocal(),)} "
                "\nCheck Out: ${f.format(DateTime.parse(day.checkOut!).toLocal(),)}" ),

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
