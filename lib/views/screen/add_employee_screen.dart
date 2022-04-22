import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/models/employee.dart';
import 'package:shrms/views/components/box_button.dart';
import '../../data/firestore/employees_firestore_helper.dart';

class AddEmployee extends StatelessWidget {
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.sp, horizontal: 30.sp),
                    child: TextFormField(
                      onChanged: (value) {
                        name = value;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                            color: const Color(0XFF329D9C), fontSize: 18.sp),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0XFF56C596),
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color(0XFF329D9C),
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
                      validator: (String? name) {
                        if (name == null || name == '' || name.isEmpty) {
                          return "Can't be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.sp, horizontal: 30.sp),
                    child: TextFormField(
                      onChanged: (value) {
                        salary = int.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Salary",
                        labelStyle: TextStyle(
                          color: const Color(0XFF329D9C),
                          fontSize: 18.sp,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0XFF56C596),
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Color(0XFF329D9C),
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
                  ),
                  Box(
                      text: "Add",
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          Employee employee =
                              Employee(name: name, salary: salary);
                          employeeFirestoreHelper.addEmployee(
                              employee: employee);
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
