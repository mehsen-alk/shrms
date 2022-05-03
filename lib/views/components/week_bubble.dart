import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/models/week.dart';
import 'package:shrms/views/screen/weeks_screen/week_details.dart';

class WeekBubble extends StatelessWidget {
  const WeekBubble({required this.week, Key? key}) : super(key: key);

  final Week week;

  @override
  Widget build(BuildContext context) {
    String firstDay =
        '${week.startingDate!.year}-${week.startingDate!.month}-${week.startingDate!.day}';
    var lastWeek = week.startingDate!.add(const Duration(days: 7));
    String lastDay = '${lastWeek.year}-${lastWeek.month}-${lastWeek.day}';
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, WeekDetails.id, arguments: week);
        },
        child: Container(
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            color: Colors.teal.shade200,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(week.id.toString()),
              Text('$firstDay -> $lastDay'),
            ],
          ),
        ),
      ),
    );
  }
}
