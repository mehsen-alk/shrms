import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/views/screen/weeks_screen/week_details.dart';

class WeekBubble extends StatelessWidget {
  const WeekBubble({required this.weekID, required this.date, Key? key})
      : super(key: key);

  final String weekID;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, WeekDetails.id, arguments: weekID);
        },
        child: Container(
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            color: Colors.teal.shade200,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(weekID), Text(date)],
          ),
        ),
      ),
    );
  }
}
