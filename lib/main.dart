import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/views/screen/employee_screen.dart';
import 'package:shrms/views/screen/home_screen.dart';

void main() async {
  runApp(const SHRMS());
}

class SHRMS extends StatelessWidget {
  const SHRMS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context) {
        return MaterialApp(
          initialRoute: 'HomeScreen',
          theme: ThemeData(
            primaryColor: const Color(0XFF329D9C),
            appBarTheme: const AppBarTheme(
              color: Color(0XFF329D9C),
            ),
          ),
          routes: {
            'HomeScreen': (context) => const HomeScreen(),
            'EmployeeScreen': (context) => const EmployeeScreen(),
          },
        );
      },
    );
  }
}
