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
  int? selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add employee work week'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<DropdownMenuItem<int>>>(
              future: dropdownMenuItemGenerator(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DropdownMenuItem<int>>> snapshot) {
                return DropdownButton<int>(
                    value: selected,
                    isExpanded: true,
                    items: snapshot.data,
                    onChanged: (l) {
                      setState(() {
                        selected = l!;
                        widget.employee.id = selected!;
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
                    // todo: firebase stuff to add the week and a little ui notify to know what state has done
                    if (selected != null) {
                      widget.weeklyWork.sat = hoursCounters[0];
                      widget.weeklyWork.sun = hoursCounters[1];
                      widget.weeklyWork.mon = hoursCounters[2];
                      widget.weeklyWork.tue = hoursCounters[3];
                      widget.weeklyWork.wed = hoursCounters[4];
                      widget.weeklyWork.the = hoursCounters[5];
                      widget.weeklyWork.fri = hoursCounters[6];

                      _helper.addEmployeeWorkWeek(
                          employee: widget.employee,
                          week: widget.week,
                          weeklyWork: widget.weeklyWork);
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

  Future<List<DropdownMenuItem<int>>> dropdownMenuItemGenerator() async {
    List<DropdownMenuItem<int>> employeesList = [];
    EmployeeFirestoreHelper helper = EmployeeFirestoreHelper();

    (await helper.employeesList).forEach((employee) {
      employeesList.add(DropdownMenuItem(
        child: Text('${employee.id}  ${employee.name}'),
        value: employee.id,
      ));
    });

    return employeesList;
  }
}
