import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayCard extends StatelessWidget {
  DayCard(
      {Key? key,
      required this.dayName,
      required this.counter,
      required this.onChange})
      : super(key: key);

  final String dayName;
  int counter;
  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dayName),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  counter--;
                  onChange(counter);
                },
              ),
              Text(counter.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  counter++;
                  onChange(counter);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
