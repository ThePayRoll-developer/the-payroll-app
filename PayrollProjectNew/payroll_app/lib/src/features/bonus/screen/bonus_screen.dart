import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:payroll_app/src/features/bonus/controller/bonus_controller.dart';
import 'package:payroll_app/src/features/bonus/model/bonus.dart';

import '../../../repository/authentication/authentication_repository.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  final BonusController _service = BonusController();


  final _authRepo = Get.put(AuthenticationRepository());

  late Future<List<Bonus>> bonus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bonus = _service.getEmployeeBonus(_authRepo.getUserEmail());
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
      body:Center(
        child:
        FutureBuilder<List<Bonus>>(
          future: bonus,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final bonusList = snapshot.data!;
                return buildBonus(bonusList);
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


  Widget buildBonus(List<Bonus> money) {
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
            subtitle: Text("Bonus Date: ${f.format(DateTime.parse(data.bonusDate!))} "
                "\nBonus Amount: ${data.amount}" ),

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
