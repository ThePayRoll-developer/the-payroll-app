import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:payroll_app/src/features/advance/controller/advance_controller.dart';
import 'package:payroll_app/src/features/advance/model/advance.dart';

import '../../../repository/authentication/authentication_repository.dart';
import '../../employee/controller/employee_controller.dart';
import '../../employee/model/employee.dart';

class AdvanceForm extends StatefulWidget {
  const AdvanceForm({super.key});

  @override
  State<AdvanceForm> createState() => _AdvanceFormState();
}

class _AdvanceFormState extends State<AdvanceForm> {
  final EmployeeController _empservice = EmployeeController();

  late Future<Employee> emp;

  final AdvanceController _service = AdvanceController();
  final _authRepo = Get.put(AuthenticationRepository());
  final _formKey = GlobalKey<FormState>();

  void getEmployee() {
    emp = _empservice.fetchEmployee(_authRepo.getUserEmail());
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _service.reason.dispose();
    _service.date.dispose();
    _service.amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Recent Salary's Advance Form",
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
                controller: _service.reason,
                decoration: const InputDecoration(labelText: "Salary's Advance Reason"),
                // onChanged: (value) => setState(() {
                //   leaveReason = value;
                // }),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter Reason' : null,
              ),
              const SizedBox(
                width: 10.0,
                height: 5.0,
              ),
              TextFormField(
                // initialValue: leaveReason,
                controller: _service.amount,
                decoration: const InputDecoration(labelText: "Amount"),
                // onChanged: (value) => setState(() {
                //   leaveReason = value;
                // }),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter Contact Number' : null,
              ),
              const SizedBox(
                width: 10.0,
                height: 5.0,
              ),
              TextFormField(
                // initialValue: leaveDate,
                controller: _service.date,
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
                      _service.date.text = f.format(pickDate);
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
                    Advance ad = Advance(
                        employee: await _empservice.fetchEmployee(
                          _authRepo.getUserEmail(),
                        ),
                        reason: _service.reason.text,
                        amount: double.parse(_service.amount.text),
                        date: _service.date.text);
                    _service.createAdvance(ad);

                    Get.snackbar("Success",
                        "Your salary's advance request has been created.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.withOpacity(0.1),
                        colorText: Colors.green);

                    // _formKey.currentState?.reset();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to save advance request.'),
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
