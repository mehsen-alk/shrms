import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeFormField extends StatelessWidget {
  const EmployeeFormField(
      {Key? key,
      required this.onChange,
      required this.labelText,
      required this.prefixIcon,
      required this.validator,
      required this.keyboardType,
      required this.inputFormatters,
      this.controller,
      required this.obscureText,
      this.suffixIcon})
      : super(key: key);

  final Function(String) onChange;
  final String labelText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 30.sp),
      child: TextFormField(
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        onChanged: onChange,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
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
            prefixIcon,
            color: const Color(0XFF329D9C),
          ),
          suffixIcon: suffixIcon,
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
