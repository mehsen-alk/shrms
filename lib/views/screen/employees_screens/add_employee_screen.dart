import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/employees_firestore_helper.dart';
import 'package:shrms/models/employee.dart';
import 'package:shrms/views/components/box_button.dart';
import 'package:shrms/views/components/employee_form_field.dart';

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
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
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
                      } else if (salary.startsWith('0')) {
                        return "Salary can not be 0";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
