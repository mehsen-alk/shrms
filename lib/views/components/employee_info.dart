import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeInfo extends StatelessWidget {
  const EmployeeInfo({
    Key? key,
    required this.employee,
    required this.text,
  }) : super(key: key);

  final dynamic employee;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text: $employee",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
      ),
    );
  }
}
