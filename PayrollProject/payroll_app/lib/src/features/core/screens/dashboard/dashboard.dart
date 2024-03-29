import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll_app/src/constants/sizes.dart';
import 'package:payroll_app/src/constants/text_strings.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black54,),
        title: Text(tAppName, style: Theme.of(context).textTheme.headlineMedium,),
        
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDashboardCardPadding),
        ),
      ),
    );
  }
}
