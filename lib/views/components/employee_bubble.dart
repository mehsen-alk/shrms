import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/employees_firestore_helper.dart';
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
                              EmployeeInfo(text: 'Sat:'),
                              EmployeeInfo(text: 'Sun:'),
                              EmployeeInfo(text: 'Mon:'),
                              EmployeeInfo(text: 'Tue:'),
                              EmployeeInfo(text: 'Wen:'),
                              EmployeeInfo(text: 'The:'),
                              EmployeeInfo(text: 'Fri:'),
                              EmployeeInfo(text: 'Total Salary:'),
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
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
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
