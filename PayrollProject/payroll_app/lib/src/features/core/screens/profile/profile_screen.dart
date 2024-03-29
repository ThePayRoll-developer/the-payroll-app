import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payroll_app/src/constants/colors.dart';
import 'package:payroll_app/src/constants/image_strings.dart';
import 'package:payroll_app/src/constants/sizes.dart';
import 'package:payroll_app/src/features/core/controllers/profile_controller/profile_controller.dart';
import 'package:payroll_app/src/features/core/screens/profile/profile_menu_widget.dart';
import 'package:payroll_app/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:payroll_app/src/features/employee/model/employee.dart';
import 'package:payroll_app/src/features/employee/screen/employee_screen.dart';
import 'package:payroll_app/src/repository/authentication/authentication_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_left)),
        title: Text("Profile", style: Theme.of(context).textTheme.headline4),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? Icons.sunny : Icons.shield_moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(image: AssetImage(tProfileImage)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),


              Text(
                "Employee Name",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Employee email",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => UpdateProfileScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text("Details",
                      style: TextStyle(color: tDarkColor)),
                ),
              ),

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              //menu
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.all_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              AuthenticationRepository.instance.logout(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              side: BorderSide.none),
                          child: const Text("Yes"),
                        ),
                      ),
                      cancel: OutlinedButton(
                          onPressed: () => Get.back(), child: const Text("No")),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
