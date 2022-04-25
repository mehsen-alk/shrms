import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/employees_firestore_helper.dart';
import 'package:shrms/models/employee.dart';
import 'package:shrms/views/components/employee_bubble.dart';
import 'package:shrms/views/screen/add_employee_screen.dart';

class EmployeeScreen extends StatefulWidget {
  static const String id = 'EmployeeScreen';
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  EmployeeFirestoreHelper employeeFirestoreHelper = EmployeeFirestoreHelper();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("SHRMS"),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: employeeFirestoreHelper.getEmployees(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                List<EmployeeBubble> employeeBubbles = [];
                if (snapshot.hasData) {
                  final List<QueryDocumentSnapshot<Object?>>? employees =
                      snapshot.data?.docs;
                  for (var employee in employees!) {
                    Employee employee1 = Employee(
                      id: employee.id,
                      name: employee['name'],
                      salary: employee['salary'],
                    );
                    final employeeBubble = EmployeeBubble(
                      employee: employee1,
                    );
                    employeeBubbles.add(employeeBubble);
                  }
                }
                return Expanded(
                  child: ListView(children: employeeBubbles),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AddEmployee.id),
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
