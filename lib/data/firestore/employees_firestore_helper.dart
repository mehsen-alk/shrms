import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shrms/models/employee.dart';

class EmployeeFirestoreHelper {
  // data will store here
  static List<Employee> _employeesList = [];

  // store all paths to avoid hard code and for easy modify
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference employeesCollection =
      firestore.collection('Employees');
  static const String idFieldPath = 'id';
  static const String nameFieldPath = 'name';
  static const String salaryFieldPath = 'salary';

  /// get the existing list or fetch it from cloud if its empty
  Future<List<Employee>> get employeesList async {
    if (_employeesList.isEmpty) {
      await updateEmployeesList();
    }
    return _employeesList;
  }

  /// fetch all employees in firestore
  ///
  /// return a sorted list of employee
  Future<List<Employee>> updateEmployeesList() async {
    // clear the existing list for avoiding duplicate data
    _employeesList = [];

    // fetch data from the cloud and but them in the list
    await employeesCollection.get().then((QuerySnapshot employees) async {
      for (var doc in employees.docs) {
        Employee employee = Employee();

        employee.id = doc[idFieldPath];
        employee.name = doc[nameFieldPath];
        employee.salary = doc[salaryFieldPath];

        _employeesList.add(employee);
      }
    });

    // sort by id
    _employeesList.sort((e1, e2) => (e1.id > e2.id) ? 1 : 0);

    return _employeesList;
  }

  /// add employee to Employee firestore collection
  ///
  /// and update the existing employee list
  ///
  /// id is auto increment
  ///
  /// the list will update after this
  void addEmployee({required Employee employee}) async {
    // no employees add the first one
    if ((await employeesList).isEmpty) {
      employee.id = 1;
      employeesCollection.doc('1').set({
        idFieldPath: employee.id,
        nameFieldPath: employee.name,
        salaryFieldPath: employee.salary
      });
    } else {
      // set employee id
      employee.id = _employeesList.last.id + 1;

      await employeesCollection.doc('${employee.id}').set({
        idFieldPath: employee.id,
        nameFieldPath: employee.name,
        salaryFieldPath: employee.salary
      });
    }
    updateEmployeesList();
  }

  /// edit info for the given employee
  ///
  /// the list will update after this
  void editEmployee({required Employee employee}) async {
    await employeesCollection.doc('${employee.id}').set({
      idFieldPath: employee.id,
      nameFieldPath: employee.name,
      salaryFieldPath: employee.salary
    });

    updateEmployeesList();
  }

  /// delete the given employee
  ///
  /// the list will update after this
  void deleteEmployee({required Employee employee}) {
    employeesCollection.doc('${employee.id}').delete();

    updateEmployeesList();
  }
}