import 'package:flutter/material.dart';
import 'package:shrms/views/screen/weeks_screen/add_employee_work_week.dart';
import '../../../models/week.dart';

class WeekDetails extends StatefulWidget {
  static const id = 'weekDetailsID';
  const WeekDetails(this.week, {Key? key}) : super(key: key);

  final Week week;
  @override
  State<WeekDetails> createState() => _WeekDetailsState();
}

class _WeekDetailsState extends State<WeekDetails> {
  List<bool> isExpanded = [true, false, false, false, false, false, false];
  List<String> days = ['sat', 'sun', 'mon', 'tue', 'wed', 'the', 'fri'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Week ${widget.week.id}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEmployeeWorkWeek.id,
              arguments: widget.week);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          children: children(),
          expansionCallback: (index, value) {
            setState(() {
              isExpanded[index] = !isExpanded[index];
            });
          },
        ),
      ),
    );
  }

  List<ExpansionPanel> children() {
    List<ExpansionPanel> expansionPanels = [];
    DateTime? time = widget.week.startingDate;
    for (int i = 0; i < 7; i++) {
      expansionPanels.add(ExpansionPanel(
        headerBuilder: (context, isOpen) => Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(days[i]),
                Text(
                    '${time!.add(Duration(days: i)).year}-${time.add(Duration(days: i)).month}-${time.add(Duration(days: i)).day}'),
                const SizedBox(),
              ],
            ),
          ),
        ),
        body: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            children: const [
              Text('1. Mehsen     3'),
              Text('2. assaf      5'),
              Text('3. mohamed    9'),
              Text('4. ali        4'),
            ],
          ),
        ),
        isExpanded: isExpanded[i],
      ));
    }

    return expansionPanels;
  }
}
