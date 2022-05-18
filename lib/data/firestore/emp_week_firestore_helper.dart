import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shrms/data/firestore/paths.dart';
import 'package:shrms/models/employee.dart';
import 'package:shrms/models/week.dart';
import 'package:shrms/models/emp_week_.dart';

class EmpWeekFirestoreHelper {
  // data will store here
  static List<EmpWeek> _empWeek = [];

  /// get the existing list or fetch it from cloud if its empty
  Future<List<EmpWeek>> get empWeekList async {
    if (_empWeek.isEmpty) {
      await updateEmployeesList();
    }
    return _empWeek;
  }

  /// fetch all records in firestore
  Future<List<EmpWeek>> updateEmployeesList() async {
    // clear the existing list to avoiding duplicate data
    _empWeek = [];

    // fetch data from the cloud and but them in the list
    await EmpWeekPaths.empWeekCollection
        .get()
        .then((QuerySnapshot empWeeks) async {
      for (var doc in empWeeks.docs) {
        EmpWeek empWeek = EmpWeek();

        empWeek.empID = doc[EmpWeekPaths.empId];
        empWeek.empName = doc[EmpWeekPaths.empName];
        empWeek.weekID = doc[EmpWeekPaths.weekId];
        empWeek.sat = doc[EmpWeekPaths.sat];
        empWeek.sun = doc[EmpWeekPaths.sun];
        empWeek.mon = doc[EmpWeekPaths.mon];
        empWeek.tue = doc[EmpWeekPaths.tue];
        empWeek.wed = doc[EmpWeekPaths.wed];
        empWeek.the = doc[EmpWeekPaths.the];
        empWeek.fri = doc[EmpWeekPaths.fri];

        _empWeek.add(empWeek);
      }
    });

    return _empWeek;
  }

  /// add employee work details in a given week
  void addEmployeeWorkWeek(
      {required Employee employee,
      required Week week,
      required EmpWeek weeklyWork}) {
    EmpWeekPaths.empWeekCollection.doc('${week.id}_${employee.id}').set({
      EmpWeekPaths.empId: employee.id,
      EmpWeekPaths.empName: employee.name,
      EmpWeekPaths.weekId: week.id,
      EmpWeekPaths.sat: weeklyWork.sat,
      EmpWeekPaths.sun: weeklyWork.sun,
      EmpWeekPaths.mon: weeklyWork.mon,
      EmpWeekPaths.tue: weeklyWork.tue,
      EmpWeekPaths.wed: weeklyWork.wed,
      EmpWeekPaths.the: weeklyWork.the,
      EmpWeekPaths.fri: weeklyWork.fri,
    });
  }

  Future<List<EmpWeek>> getEmployeesInWeek({required Week week}) async {
    List<EmpWeek> employeesInWeek = [];

    (await empWeekList).forEach((empWeek) {
      if (empWeek.weekID == week.id) {
        employeesInWeek.add(empWeek);
      }
    });

    // sort by empID
    employeesInWeek.sort((e1, e2) {
      return (e1.empID > e2.empID) ? 1 : 0;
    });

    return employeesInWeek;
  }
}
