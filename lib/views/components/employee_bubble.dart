import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/emp_week_firestore_helper.dart';
import 'package:shrms/data/firestore/employees_firestore_helper.dart';
import 'package:shrms/models/emp_week_.dart';
import 'package:shrms/models/employee.dart';
import 'package:shrms/views/components/employee_info.dart';
import 'package:shrms/views/screen/employees_screens/edit_employee_screen.dart';

class EmployeeBubble extends StatelessWidget {
  final Employee employee;

  const EmployeeBubble({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmployeeFirestoreHelper _helper = EmployeeFirestoreHelper();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: const Color(0XFF205072),
            builder: (context) {
              return ModalBottomSheet(employee: employee, helper: _helper);
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0XFF56C596),
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: const CircleAvatar(
                  backgroundColor: Color(0XFF56C596),
                  child: Icon(
                    Icons.person,
                    color: Color(0XFF205072),
                    size: 50.0,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  EmployeeInfo(text: 'ID: ${employee.id}'),
                  EmployeeInfo(text: 'Name: ${employee.name}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    Key? key,
    required this.employee,
    required EmployeeFirestoreHelper helper,
  })  : _helper = helper,
        super(key: key);

  final Employee employee;
  final EmployeeFirestoreHelper _helper;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 300.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    EmployeeInfo(text: 'ID: ${employee.id}'),
                    EmployeeInfo(text: 'Name: ${employee.name}'),
                    EmployeeInfo(text: 'Salary: ${employee.salary}'),
                    FutureBuilder<List<EmpWeek>>(
                        future: EmpWeekFirestoreHelper()
                            .getEmployeeWeeklyWork(employee),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<EmpWeek>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            List<EmployeeInfo> employeeInfoList = [
                              const EmployeeInfo(text: '')
                            ];
                            int totalWork = 0;

                            snapshot.data!.forEach((empWeek) {
                              employeeInfoList.add(EmployeeInfo(
                                  text:
                                      'week ${empWeek.weekID}: ${empWeek.totalWork}'));
                              totalWork += empWeek.totalWork;
                            });
                            employeeInfoList.add(const EmployeeInfo(text: ''));
                            employeeInfoList.add(
                                EmployeeInfo(text: 'total work: $totalWork'));
                            employeeInfoList.add(EmployeeInfo(
                                text:
                                    'total salary: ${totalWork * employee.salary} \$'));

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: employeeInfoList,
                            );
                          } else {
                            return const Text('no data');
                          }
                        }),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _helper.deleteEmployee(employee: employee);
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.delete,
                      size: 28.sp,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(150.w, 25.w),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.sp),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, EditEmployee.id,
                          arguments: employee);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 28.sp,
                    ),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(150.w, 25.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
