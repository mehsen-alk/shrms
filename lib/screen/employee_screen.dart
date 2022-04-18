import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/components/box_button.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHRMS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Box(text: "Add Employee", onPress: () {}),
            SizedBox(
              height: 10.h,
            ),
            Box(text: "Edit Employee", onPress: () {}),
          ],
        ),
      ),
    );
  }
}
