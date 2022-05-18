import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/employees_firestore_helper.dart';
import 'package:shrms/models/employee.dart';
import 'package:shrms/views/components/box_button.dart';
import 'package:shrms/views/components/employee_form_field.dart';

class EditEmployee extends StatefulWidget {
  static const String id = 'EditEmployee';
  const EditEmployee(this.employee, {Key? key}) : super(key: key);

  final Employee employee;

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final EmployeeFirestoreHelper _helper = EmployeeFirestoreHelper();
  static final _formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("SHRMS"),
          ),
          body: Form(
            key: _formKey1,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 200.w,
                      color: const Color(0XFF205072),
                    ),
                    EmployeeFormField(
                      controller:
                          TextEditingController(text: widget.employee.name),
                      onChange: (value) {
                        widget.employee.name = value;
                      },
                      prefixIcon: Icons.person,
                      labelText: 'Name',
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
                      obscureText: false,
                    ),
                    EmployeeFormField(
                      controller: TextEditingController(
                          text: widget.employee.salary.toString()),
                      onChange: (value) {
                        widget.employee.salary = int.parse(value);
                      },
                      prefixIcon: Icons.account_balance_wallet_outlined,
                      labelText: 'Salary',
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
                      obscureText: false,
                    ),
                    Box(
                      text: 'Edit',
                      onPress: () {
                        if (_formKey1.currentState!.validate()) {
                          _helper.editEmployee(employee: widget.employee);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
