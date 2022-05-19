import 'package:flutter/material.dart';
import 'package:shrms/data/firestore/emp_week_firestore_helper.dart';
import 'package:shrms/data/firestore/employees_firestore_helper.dart';
import 'package:shrms/models/employee.dart';
import 'package:shrms/models/week.dart';
import 'package:shrms/models/emp_week_.dart';
import 'package:shrms/views/components/day_card.dart';

class AddEmployeeWorkWeek extends StatefulWidget {
  AddEmployeeWorkWeek(this.week, {Key? key}) : super(key: key);
  static const id = 'AddEmployeeWorkWeek';

  final Week week;
  final Employee employee = Employee();
  final EmpWeek weeklyWork = EmpWeek();

  @override
  State<AddEmployeeWorkWeek> createState() => _AddEmployeeWorkWeekState();
}

class _AddEmployeeWorkWeekState extends State<AddEmployeeWorkWeek> {
  final EmpWeekFirestoreHelper _helper = EmpWeekFirestoreHelper();
  List<int> hoursCounters = [0, 0, 0, 0, 0, 0, 0];
  List<String> days = ['sat', 'sun', 'mon', 'tue', 'wed', 'the', 'fri'];
  Employee? selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add employee work week'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<DropdownMenuItem<Employee>>>(
              future: dropdownMenuItemGenerator(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DropdownMenuItem<Employee>>> snapshot) {
                return DropdownButton<Employee>(
                    value: selected,
                    isExpanded: true,
                    items: snapshot.data,
                    onChanged: (l) {
                      setState(() {
                        selected = l!;
                        widget.employee.id = selected!.id;
                        widget.employee.name = selected!.name;
                      });
                    });
              },
            ),
            const SizedBox(
              height: 60,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, i) {
                  return DayCard(
                      dayName: days[i],
                      counter: hoursCounters[i],
                      onChange: (v) {
                        setState(() {
                          hoursCounters[i] = v;
                        });
                      });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.teal)),
                  child: const Text('submit'),
                  onPressed: () {
                    if (selected != null) {
                      widget.weeklyWork.sat = hoursCounters[0];
                      widget.weeklyWork.sun = hoursCounters[1];
                      widget.weeklyWork.mon = hoursCounters[2];
                      widget.weeklyWork.tue = hoursCounters[3];
                      widget.weeklyWork.wed = hoursCounters[4];
                      widget.weeklyWork.the = hoursCounters[5];
                      widget.weeklyWork.fri = hoursCounters[6];

                      if (_helper.addEmployeeWorkWeek(
                          employee: widget.employee,
                          week: widget.week, //
                          weeklyWork: widget.weeklyWork)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Added successfully'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Addition failed, please try again'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<List<DropdownMenuItem<Employee>>> dropdownMenuItemGenerator() async {
    List<DropdownMenuItem<Employee>> employeesList = [];
    EmployeeFirestoreHelper helper = EmployeeFirestoreHelper();

    (await helper.employeesList).forEach((employee) {
      employeesList.add(DropdownMenuItem(
        child: Text('${employee.id}  ${employee.name}'),
        value: employee,
      ));
    });

    return employeesList;
  }
}
