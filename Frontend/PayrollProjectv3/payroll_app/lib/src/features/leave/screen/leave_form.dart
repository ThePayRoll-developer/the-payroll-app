import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:payroll_app/src/constants/colors.dart';
import 'package:payroll_app/src/features/leave/controller/leave_controller.dart';
import 'package:payroll_app/src/features/leave/model/leave.dart';

import '../../../repository/authentication/authentication_repository.dart';
import '../../employee/controller/employee_controller.dart';
import '../../employee/model/employee.dart';

class LeaveForm extends StatefulWidget {
  const LeaveForm({super.key});

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  final EmployeeController _empservice = EmployeeController();

  late Future<Employee> emp;

  final LeaveController _service = LeaveController();
  final _authRepo = Get.put(AuthenticationRepository());
  final _formKey = GlobalKey<FormState>();

  // date time
  late String? chooseDate;

  // model class properties
  late int? id;
  late Employee? employee;
  late String? contact;
  late String? leaveDate;
  late String? leaveReason;
  late bool? grant;

  void getEmployee() {
    emp = _empservice.fetchEmployee(_authRepo.getUserEmail());
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = null;
    contact = '';
    leaveDate = '';
    leaveReason = '';
    grant = false;
  }

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Leave Request",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                // initialValue: leaveReason,
                controller: _service.leaveReason,
                decoration: const InputDecoration(labelText: "Leave Reason"),
                onChanged: (value) => setState(() {
                  leaveReason = value;
                }),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter Reason' : null,
              ),
              const SizedBox(
                width: 10.0,
                height: 5.0,
              ),
              TextFormField(
                // initialValue: leaveReason,
                controller: _service.contact,
                decoration: const InputDecoration(labelText: "Contact Number"),
                onChanged: (value) => setState(() {
                  leaveReason = value;
                }),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter Contact Number' : null,
              ),
              const SizedBox(
                width: 10.0,
                height: 5.0,
              ),
              TextFormField(
                // initialValue: leaveDate,
                controller: _service.leaveDate,
                decoration: const InputDecoration(
                    icon: Icon(LineAwesomeIcons.calendar),
                    labelText: "Select a Date"),
                onTap: () async {
                  DateTime? pickDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1998),
                    lastDate: DateTime(2089),
                  );
                  if (pickDate != null) {
                    setState(() {
                      _service.leaveDate.text = f.format(pickDate);
                    });
                  }
                },

                validator: (value) =>
                    value!.isEmpty ? 'Please enter Date' : null,
              ),
              const SizedBox(
                width: 10.0,
                height: 5.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Leave leave = Leave(
                        employee: await _empservice.fetchEmployee(
                          _authRepo.getUserEmail(),
                        ),
                        contact: _service.contact.text,
                        leaveDate: _service.leaveDate.text,
                        leaveReason: _service.leaveReason.text);
                    _service.createLeave(leave);
                    Get.snackbar("Success", "Your leave request has been submitted.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.withOpacity(0.1),
                        colorText: Colors.green);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to save Leave request.'),
                      ),
                    );
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
