import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/views/components/box_button.dart';
import 'package:shrms/views/screen/employee_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("SHRMS"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Box(
                text: "Employee",
                onPress: () => Navigator.pushNamed(context, EmployeeScreen.id),
              ),
              Box(text: "Weeks", onPress: () {}),
            ],
          ),
        ),
      );
    });
  }
}
