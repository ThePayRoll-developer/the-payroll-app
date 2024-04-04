import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:payroll_app/src/constants/colors.dart';
import 'package:payroll_app/src/features/attendance/controller/attendance_controller.dart';
import 'package:payroll_app/src/features/attendance/model/attendance.dart';

import '../../../repository/authentication/authentication_repository.dart';
import '../../employee/controller/employee_controller.dart';
import '../../employee/model/employee.dart';

class AttendanceForm extends StatefulWidget {
  const AttendanceForm({super.key});

  @override
  State<AttendanceForm> createState() => _AttendanceFormState();
}

class _AttendanceFormState extends State<AttendanceForm> {
  final EmployeeController _empservice = EmployeeController();

  late Future<Employee> emp;

  // late Future<Attendance> latestAttendance;
  late Future<List<Attendance>> latestAttendance;

  // button is active
  late bool isActive;

  //screen
  double screenWidth = 0;

  // attendance
  final AttendanceController _service = AttendanceController();
  final _authRepo = Get.put(AuthenticationRepository());
  final _formKey = GlobalKey<FormState>();

// model class properties
  late int? id;
  late Employee? employee;
  late String? checkIn;
  late String? checkOut;

  void getEmployee() {
    emp = _empservice.fetchEmployee(_authRepo.getUserEmail());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = null;

    checkOut = null;
    checkIn = null;

    isActive = true;

    // method call
    emp = _empservice.fetchEmployee(_authRepo.getUserEmail());
    latestAttendance = _service.getEmployeeLatestDays(_authRepo.getUserEmail());
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Attendance Entry",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text("Welcome"),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Employee: ${_authRepo.getUserEmail()}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "Today's Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 32),
                height: 150,
                decoration: BoxDecoration(
                  color: isDarkMode ? tSecondaryColor : tWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? tSecondaryColor : tWhiteColor,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   child: FutureBuilder<List<Attendance>>(
                          //     future: latestAttendance,
                          //     builder: (context, snapshot) {
                          //       if (snapshot.connectionState ==
                          //           ConnectionState.done) {
                          //         if (snapshot.hasData) {
                          //           final attend = snapshot.data!;
                          //           return buildAttendance(attend);
                          //         } else if (snapshot.hasError) {
                          //           return Center(
                          //             child: Text(
                          //               snapshot.error.toString(),
                          //             ),
                          //           );
                          //         } else {
                          //           return const Center(
                          //             child: Text("Something went wrong."),
                          //           );
                          //         }
                          //       } else {
                          //         return const Center(
                          //             child: CircularProgressIndicator());
                          //         }
                          //     },
                          //   ),
                          // ),
                          const Text(
                            "Clock",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StreamBuilder(
                                stream:
                                    Stream.periodic(const Duration(seconds: 1)),
                                builder: (context, snapshot) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      DateFormat('hh:mm:ss a').format(
                                        DateTime.now(),
                                      ),
                                      style: TextStyle(
                                        fontSize: screenWidth / 32,
                                        color: isDarkMode ?  tWhiteColor : tSecondaryColor ,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // StreamBuilder(
              //     stream: Stream.periodic(const Duration(seconds: 1)),
              //     builder: (context, snapshot){
              //       return Container(
              //         alignment: Alignment.centerLeft,
              //         child: Text(
              //           DateFormat('hh:mm:ss a').format(DateTime.now(),),
              //         style: TextStyle(
              //           fontSize: screenWidth/32,
              //           color: tSecondaryColor,
              //         ),
              //         ),
              //       );
              //     }),

              Container(
                margin: const EdgeInsets.only(top: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return null; // Defer to the widget's default.
                          }),
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.white;
                            }
                            return null; // Defer to the widget's default.
                          }),
                        ),
                        onPressed: isActive
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  Attendance attendance = Attendance(
                                    id: id,
                                    employee: await _empservice.fetchEmployee(
                                      _authRepo.getUserEmail(),
                                    ),
                                  );
                                  try {
                                    await _service.createAttendance(attendance);
                                    Get.snackbar(
                                        "Success", "Your CheckIn is complete.",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor:
                                            Colors.green.withOpacity(0.1),
                                        colorText: Colors.green);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Failed to save Attendance.'),
                                      ),
                                    );
                                  }
                                }
                                setState(() {
                                  isActive = false;
                                });
                              }
                            : null,
                        child: const Text(
                          'Check In',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAttendance(List<Attendance> attendance) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50.0),
      child: ListView.builder(
        itemCount: attendance.length,
        itemBuilder: (context, index) {
          final day = attendance[index];
          if (kDebugMode) {
            print(day);
          }
          return ListTile(
            title:
                // Text(day.checkIn!),
                Text("Employee: ${day.employee?.name!}"),
            subtitle:
                Text("Check In: ${f.format(DateTime.parse(day.checkIn!))} "
                    "\nCheck Out: ${f.format(DateTime.parse(day.checkOut!))}"),

            contentPadding: const EdgeInsets.all(10.0),
            // subtitle: Text(f.format(DateTime.parse(day.checkOut!))),
          );
        },
      ),
    );
  }
}
