import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeFormField extends StatelessWidget {
  const EmployeeFormField(
      {Key? key,
      required this.onChange,
      required this.labelText,
      required this.icon,
      required this.validator})
      : super(key: key);

  final Function(String) onChange;
  final String labelText;
  final IconData icon;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 30.sp),
      child: TextFormField(
        onChanged: onChange,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              TextStyle(color: const Color(0XFF329D9C), fontSize: 18.sp),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0XFF56C596),
            ),
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0XFF329D9C),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0XFF56C596),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0XFF56C596),
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}