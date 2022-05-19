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
      await updateEmployeesWeeksList();
    }
    return _empWeek;
  }

  /// fetch all records in firestore
  Future<List<EmpWeek>> updateEmployeesWeeksList() async {
    print(1.3);
    // clear the existing list to avoiding duplicate data
    _empWeek = [];

    // fetch data from the cloud and but them in the list
    await EmpWeekPaths.empWeekCollection.get().then((QuerySnapshot empWeeks) {
      empWeeks.docs.forEach((doc) {
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
      });
    });

    return _empWeek;
  }

  /// add employee work details in a given week
  bool addEmployeeWorkWeek(
      {Employee? employee, Week? week, EmpWeek? weeklyWork}) {
    try {
      EmpWeekPaths.empWeekCollection.doc('${week?.id}_${employee?.id}').set({
        EmpWeekPaths.empId: employee?.id,
        EmpWeekPaths.empName: employee?.name,
        EmpWeekPaths.weekId: week?.id,
        EmpWeekPaths.sat: weeklyWork?.sat,
        EmpWeekPaths.sun: weeklyWork?.sun,
        EmpWeekPaths.mon: weeklyWork?.mon,
        EmpWeekPaths.tue: weeklyWork?.tue,
        EmpWeekPaths.wed: weeklyWork?.wed,
        EmpWeekPaths.the: weeklyWork?.the,
        EmpWeekPaths.fri: weeklyWork?.fri,
      });
      return true;
    } catch (e) {
      print('this is error--> $e');
      return false;
    }
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

  Future<List<EmpWeek>> getEmployeeWeeklyWork(Employee employee) async {
    await updateEmployeesWeeksList();

    List<EmpWeek> weeklyWork = [];

    (await empWeekList).forEach((empWeek) {
      if (empWeek.empID == employee.id) {
        empWeek.totalWork = 0;
        empWeek.totalWork += empWeek.sat;
        empWeek.totalWork += empWeek.sun;
        empWeek.totalWork += empWeek.mon;
        empWeek.totalWork += empWeek.tue;
        empWeek.totalWork += empWeek.wed;
        empWeek.totalWork += empWeek.the;
        empWeek.totalWork += empWeek.fri;
        weeklyWork.add(empWeek);
      }
    });

    print(2);
    print(weeklyWork);

    return weeklyWork;
  }
}
