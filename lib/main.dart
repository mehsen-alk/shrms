import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/views/screen/add_employee_screen.dart';
import 'package:shrms/views/screen/add_employee_work_week.dart';
import 'package:shrms/views/screen/employee_screen.dart';
import 'package:shrms/views/screen/home_screen.dart';
import 'package:shrms/views/screen/week_details.dart';
import 'package:shrms/views/screen/weeks_screen.dart';

// hi
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SHRMS());
}

class SHRMS extends StatelessWidget {
  const SHRMS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context) {
        return MaterialApp(
          initialRoute: HomeScreen.id,
          theme: ThemeData(
            primaryColor: const Color(0XFF329D9C),
            appBarTheme: const AppBarTheme(
              color: Colors.teal,
            ),
          ),
          routes: {
            HomeScreen.id: (context) => const HomeScreen(),
            EmployeeScreen.id: (context) => const EmployeeScreen(),
            AddEmployee.id: (context) => const AddEmployee(),
            WeeksScreen.id: (context) => WeeksScreen(),
            WeekDetails.id: (context) => WeekDetails(
                  ModalRoute.of(context)?.settings.arguments as String,
                ),
            AddEmployeeWorkWeek.id: (context) => AddEmployeeWorkWeek(
                ModalRoute.of(context)?.settings.arguments as String),
          },
        );
      },
    );
  }
}
