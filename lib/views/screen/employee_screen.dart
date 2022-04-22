import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/employees_firestore_helper.dart';
import 'package:shrms/views/components/employee_bubble.dart';

class EmployeeScreen extends StatefulWidget {
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
            StreamBuilder(
              stream: employeeFirestoreHelper.getEmployees(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<EmployeeBubble> employeeBubbles = [];
                if (snapshot.hasData) {
                  final employees = snapshot.data.docs.reversed;
                  for (var employee in employees) {
                    final employeeName = employee.data()['name'];
                    final employeeID = FirebaseFirestore.instance
                        .collection('Employees')
                        .doc()
                        .id;
                    final employeeSalary = employee.data()['salary'];
                    final employeeBubble = EmployeeBubble(
                        name: employeeName,
                        id: employeeID,
                        salary: employeeSalary);
                    employeeBubbles.add(employeeBubble);
                  }
                }
                return Expanded(
                  child: ListView(children: employeeBubbles),
                );
              },
            ),
            // Padding(
            //   padding: EdgeInsets.all(18.sp),
            //   child: Container(
            //     alignment: Alignment.bottomRight,
            //     child: FloatingActionButton(
            //       onPressed: () => Navigator.pushNamed(context, 'AddEmployee'),
            //       child: const Icon(Icons.add),
            //     ),
            //   ),
            // )
          ],
        ),
      );
    });
  }
}
