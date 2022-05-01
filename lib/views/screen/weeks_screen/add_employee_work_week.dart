import 'package:flutter/material.dart';
import 'package:shrms/views/components/day_card.dart';

class AddEmployeeWorkWeek extends StatefulWidget {
  const AddEmployeeWorkWeek(this.weekID, {Key? key}) : super(key: key);
  static const id = 'AddEmployeeWorkWeek';

  final String weekID;

  @override
  State<AddEmployeeWorkWeek> createState() => _AddEmployeeWorkWeekState();
}

class _AddEmployeeWorkWeekState extends State<AddEmployeeWorkWeek> {
  List<int> hoursCounters = [0, 0, 0, 0, 0, 0, 0];
  List<String> days = ['sat', 'sun', 'mon', 'tue', 'wed', 'the', 'fri'];
  String? selected = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add employee work week'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton<String>(
                isExpanded: true,
                value: selected,
                items: const [
                  DropdownMenuItem(child: Text('1. Mohsen'), value: '1'),
                  DropdownMenuItem(child: Text('2. Assaf'), value: '2'),
                  DropdownMenuItem(child: Text('3. Ali'), value: '3'),
                ],
                onChanged: (l) {
                  setState(() {
                    selected = l;
                  });
                }),
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
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
