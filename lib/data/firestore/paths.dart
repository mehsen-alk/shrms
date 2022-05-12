import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeePaths {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference employeesCollection =
      firestore.collection('Employees');
  static const String idFieldPath = 'id';
  static const String nameFieldPath = 'name';
  static const String salaryFieldPath = 'salary';
}

class WeekPaths {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference weeksCollection =
      firestore.collection('Weeks');
  static const String idFieldPath = 'id';
  static const String startingDateFiledPath = 'starting date';
  static const String dayMapField = 'day';
  static const String monthMapField = 'month';
  static const String yearMapField = 'year';
}

class EmpWeekPaths {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference empWeekCollection =
      firestore.collection('Emp_Week');
  static const String empId = 'employee_id';
  static const String weekId = 'week_id';
  static const String sat = 'sat';
  static const String sun = 'sun';
  static const String mon = 'mon';
  static const String tue = 'tue';
  static const String wed = 'wed';
  static const String the = 'the';
  static const String fri = 'fri';
}
