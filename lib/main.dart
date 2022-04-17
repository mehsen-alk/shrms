import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/screen/home_screen.dart';

void main() async {
  runApp(const SHrms());
}

class SHrms extends StatelessWidget {
  const SHrms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context) {
        return const MaterialApp(
          // Use this line to prevent extra rebuilds
          useInheritedMediaQuery: true,
          home: HomeScreen(),
        );
      },
    );
  }
}
