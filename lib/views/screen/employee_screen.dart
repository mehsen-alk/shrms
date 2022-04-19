import 'package:flutter/material.dart';
import 'package:shrms/views/components/box_button.dart';

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
            Box(text: "Edit Employee", onPress: () {}),
            Box(text: "Show Employee", onPress: () {}),
          ],
        ),
      ),
    );
  }
}
