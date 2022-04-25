import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/employees_firestore_helper.dart';
import 'package:shrms/models/employee.dart';
import 'package:shrms/views/components/box_button.dart';

class AddEmployee extends StatelessWidget {
  static const String id = 'AddEmployee';
  const AddEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    late String name;
    late int salary;
    EmployeeFirestoreHelper employeeFirestoreHelper = EmployeeFirestoreHelper();
    return ScreenUtilInit(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("SHRMS"),
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmployeeFormField(
                    labelText: 'Name',
                    icon: Icons.person,
                    onChange: (value) {
                      name = value;
                    },
                    validator: (String? name) {
                      if (name == null || name == '' || name.isEmpty) {
                        return "Can't be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  EmployeeFormField(
                    labelText: 'Salary',
                    icon: Icons.account_balance_wallet_outlined,
                    onChange: (value) {
                      salary = int.parse(value);
                    },
                    validator: (String? salary) {
                      if (salary == null || salary == '' || salary.isEmpty) {
                        return "Can't be empty";
                      } else if (salary.contains('-')) {
                        return "Salary can't be negative";
                      } else if (salary.contains("a")) {
                        return "Salary can not  contain characters";
                      } else if (salary.startsWith('0')) {
                        return "Salary can not be 0";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Box(
                      text: "Add",
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          Employee employee =
                              Employee(name: name, salary: salary);
                          employeeFirestoreHelper.addEmployee(
                              employee: employee);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

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
