import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_app/src/constants/colors.dart';
import 'package:payroll_app/src/constants/image_strings.dart';
import 'package:payroll_app/src/constants/sizes.dart';
import 'package:payroll_app/src/constants/text_strings.dart';
import 'package:payroll_app/src/features/attendance/screen/attendance_screen.dart';
import 'package:payroll_app/src/features/core/screens/profile/profile_screen.dart';
import 'package:payroll_app/src/features/employee/screen/employee_screen.dart';
import 'package:payroll_app/src/features/salary/model/salary.dart';
import 'package:payroll_app/src/features/salary/screen/salary_screen.dart';

import '../carousel_dashboard/carousel_dashboard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black54,
        ),
        title: Text(
          tAppName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20.0, top: 7.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: tCardBgColor,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDashboardCardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tDashboardHeading,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: tDashboardPadding,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton(
                            onPressed: () {
                              Get.to(() => AttendanceScreen());
                            },
                            child: const Text("Attendance")),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton(
                            onPressed: () {
                              Get.to(() => ProfileScreen());
                            },
                            child: const Text("Profile")),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton(
                            onPressed: () {
                              Get.toNamed('/bonus');
                            },
                            child: const Text("Bonus")),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton(
                            onPressed: () {
                              Get.toNamed('/advance');
                            },
                            child: const Text("Advance")),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton(
                          onPressed: () {
                            Get.toNamed('/leave');
                          },
                          child: const Text("Leave"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => SalaryScreen());
                          },
                          child: const Text("Salary"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => EmployeeScreen());
                          },
                          child: const Text("Employee"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Padding(
                padding: EdgeInsets.all(tDefaultSize),
                child: CarouselDashboard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


