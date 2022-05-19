import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayCard extends StatefulWidget {
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
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.dayName),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (widget.counter != 0) {
                    widget.counter--;
                    widget.onChange(widget.counter);
                  }
                },
              ),
              Text(widget.counter.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  widget.counter++;
                  widget.onChange(widget.counter);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
