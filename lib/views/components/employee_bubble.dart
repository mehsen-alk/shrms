import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeBubble extends StatelessWidget {
  final String name;
  final String id;
  final int salary;
  const EmployeeBubble(
      {Key? key, required this.name, required this.id, required this.salary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0XFF56C596),
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: const CircleAvatar(
                backgroundColor: Color(0XFF56C596),
                child: Icon(
                  Icons.person,
                  color: Color(0XFF205072),
                  size: 50.0,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "ID: $id",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  "Name: $name",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  "Salary: $salary",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//k
