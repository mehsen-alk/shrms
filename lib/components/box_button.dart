import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Box extends StatelessWidget {
  final String text;
  final Function onPress;
  const Box({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(20.r),
      ),
      width: 120.w,
      height: 120.w,
      child: TextButton(
        onPressed: () {
          onPress();
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
