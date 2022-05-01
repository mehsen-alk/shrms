import 'package:flutter/material.dart';
import 'package:shrms/views/screen/weeks_screen/add_employee_work_week.dart';

class WeekDetails extends StatefulWidget {
  static const id = 'weekDetailsID';
  const WeekDetails(this.weekID);

  final String weekID;

  @override
  State<WeekDetails> createState() => _WeekDetailsState();
}

class _WeekDetailsState extends State<WeekDetails> {
  List<bool> isExpanded = [true, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Week ${widget.weekID}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEmployeeWorkWeek.id,
              arguments: widget.weekID);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          children: [
            ExpansionPanel(
              headerBuilder: (context, isOpen) =>
                  const Center(child: Text('sat')),
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
              isExpanded: isExpanded[0],
            ),
            ExpansionPanel(
              headerBuilder: (context, isOpen) =>
                  const Center(child: Text('sun')),
              body: const Text('lol'),
              isExpanded: isExpanded[1],
            ),
            ExpansionPanel(
              headerBuilder: (context, isOpen) =>
                  const Center(child: Text('mon')),
              body: const Text('lol'),
              isExpanded: isExpanded[2],
            ),
            ExpansionPanel(
              headerBuilder: (context, isOpen) =>
                  const Center(child: Text('tue')),
              body: const Text('lol'),
              isExpanded: isExpanded[3],
            ),
            ExpansionPanel(
              headerBuilder: (context, isOpen) =>
                  const Center(child: Text('wed')),
              body: const Text('lol'),
              isExpanded: isExpanded[4],
            ),
            ExpansionPanel(
              headerBuilder: (context, isOpen) =>
                  const Center(child: Text('the')),
              body: const Text('lol'),
              isExpanded: isExpanded[5],
            ),
            ExpansionPanel(
              headerBuilder: (context, isOpen) =>
                  const Center(child: Text('fri')),
              body: const Text('lol'),
              isExpanded: isExpanded[6],
            ),
          ],
          expansionCallback: (index, value) {
            setState(() {
              isExpanded[index] = !isExpanded[index];
            });
          },
        ),
      ),
    );
  }
}
