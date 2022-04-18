import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/screen/employee_screen.dart';

void main() async {
  runApp(const SHrms());
}

class SHrms extends StatelessWidget {
  const SHrms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (BuildContext context) {
        return MaterialApp(
          // Use this line to prevent extra rebuilds
          useInheritedMediaQuery: true,
          home: const EmployeeScreen(),
          theme: ThemeData(
            primaryColor: const Color(0XFF329D9C),
            appBarTheme: const AppBarTheme(
              color: Color(0XFF329D9C),
            ),
          ),
        );
      },
    );
  }
}
