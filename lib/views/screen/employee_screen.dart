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
  final EmployeeFirestoreHelper _helper = EmployeeFirestoreHelper();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("SHRMS"),
        ),
        body: FutureBuilder<List<Employee>>(
          future: _helper.employeesList,
          builder: _futureBuilder,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AddEmployee.id),
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  Widget _futureBuilder(
      BuildContext context, AsyncSnapshot<List<Employee>> employees) {
    List<EmployeeBubble> employeesBubble = [];

    if (employees.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (employees.connectionState == ConnectionState.done) {
      if (employees.hasData) {
        employees.data?.forEach((employee) {
          employeesBubble.add(EmployeeBubble(employee: employee));
        });
        if (employeesBubble.isNotEmpty) {
          return ListView(
            shrinkWrap: true,
            children: employeesBubble,
          );
        } else {
          return const Center(child: Text('no data'));
        }
      }
    }
    return const Text('error');
  }
}
