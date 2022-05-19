import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/paths.dart';
import 'package:shrms/views/components/box_button.dart';
import 'package:shrms/views/screen/admin_screens/admin_page.dart';
import 'package:shrms/views/screen/employees_screens/employee_screen.dart';
import 'package:shrms/views/screen/weeks_screen/weeks_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("SHRMS"),
          actions: [
            IconButton(
                onPressed: () async {
                  await AdminPaths.firebaseAuth.signOut();
                  Navigator.pushNamed(context, AdminPage.id);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Box(
                text: "Employee",
                onPress: () => Navigator.pushNamed(context, EmployeeScreen.id),
              ),
              Box(
                  text: "Weeks",
                  onPress: () {
                    Navigator.pushNamed(context, WeeksScreen.id);
                  }),
            ],
          ),
        ),
      );
    });
  }
}
