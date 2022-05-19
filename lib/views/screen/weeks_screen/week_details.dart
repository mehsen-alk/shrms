import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/emp_week_firestore_helper.dart';
import 'package:shrms/models/emp_week_.dart';
import 'package:shrms/models/week.dart';
import 'package:shrms/views/screen/weeks_screen/add_employee_work_week.dart';

class WeekDetails extends StatefulWidget {
  static const id = 'weekDetailsID';
  const WeekDetails(this.week, {Key? key}) : super(key: key);

  final Week week;
  @override
  State<WeekDetails> createState() => _WeekDetailsState();
}

class _WeekDetailsState extends State<WeekDetails> {
  EmpWeekFirestoreHelper helper = EmpWeekFirestoreHelper();

  List<bool> isExpanded = [true, false, false, false, false, false, false];
  List<String> days = ['sat', 'sun', 'mon', 'tue', 'wed', 'the', 'fri'];
  late List<EmpWeek> empWeek;

  @override
  void initState() {
    super.initState();
  }

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
      body: RefreshIndicator(
        onRefresh: () async {
          await EmpWeekFirestoreHelper().updateEmployeesList();
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<List<ExpansionPanel>>(
            future: children(widget.week),
            builder: (BuildContext context,
                AsyncSnapshot<List<ExpansionPanel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ExpansionPanelList(
                  children: snapshot.data!,
                  expansionCallback: (index, value) {
                    setState(() {
                      isExpanded[index] = !isExpanded[index];
                    });
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<ExpansionPanel>> children(Week week) async {
    List<EmpWeek> empInWeek =
        await EmpWeekFirestoreHelper().getEmployeesInWeek(week: week);

    List<Text> empInDay = [];

    List<ExpansionPanel> expansionPanels = [];
    DateTime? time = widget.week.startingDate;
    for (int i = 0; i < 7; i++) {
      empInDay = [];

      empInWeek.forEach((element) {
        List<int> temp = [
          element.sat,
          element.sun,
          element.mon,
          element.tue,
          element.wed,
          element.the,
          element.fri
        ];
        empInDay.add(Text('${element.empID}. ${element.empName}: ${temp[i]}'));
      });

      expansionPanels.add(ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (context, isOpen) => Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.sp),
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
            children: [
              ListView(
                shrinkWrap: true,
                children: empInDay,
              ),
            ],
          ),
        ),
        isExpanded: isExpanded[i],
      ));
    }

    return expansionPanels;
  }
}
