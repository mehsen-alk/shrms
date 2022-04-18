import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Box extends StatelessWidget {
  final String text;
  final Function onPress;
  const Box({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress(),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0XFF56C596),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(300.w, 50.w),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
        ),
      ),
    );
  }
}
