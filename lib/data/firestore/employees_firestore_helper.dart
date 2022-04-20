import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shrms/models/employee.dart';

class EmployeeFirestoreHelper {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference employeesCollection =
      firestore.collection('Employees');
  final nameFieldPath = 'name';
  final salaryFieldPath = 'salary';

  /// return a snapshot to use it inside stream builder
  ///
  /// StreamBuilder<QuerySnapshot>(
  ///  stream: FireStoreHelper().getEmployees(),
  ///  builder: (context, snapshot) {
  ///    List<Text> employees = [];
  ///    if (snapshot.hasData) {
  ///      snapshot.data?.docs.forEach((employee) {
  ///        employees.add(Text(employee[nameFieldPath]));
  ///      });
  ///    }
  ///    return Expanded(
  ///      child: ListView(
  ///        children: employees,
  ///      ),
  ///    );
  /// }),
  ///
  /// or use it like this:
  ///
  /// var f = EmployeeFirestoreHelper().getEmployees();
  /// f.forEach((querySnapshot) {
  ///   for (var doc in querySnapshot.docs) {
  ///     print('name: ${doc[nameFieldPath]}');
  ///     print('salary: ${doc[salaryFieldPath]}');
  /// }
  /// });
  Stream<QuerySnapshot<Object?>> getEmployees() {
    return employeesCollection.snapshots();
  }

  void addEmployee({required Employee employee}) async {
    // check if the collection employee exist if not create it
    // because there is no directly way to do that, we check if there is an document
    // in the collection by check its size
    if ((await employeesCollection
            .limit(1)
            .get()
            .then((value) => value.size)) ==
        0) {
      return await employeesCollection.doc('1').set(
          {nameFieldPath: employee.name, salaryFieldPath: employee.salary});
    }
    await employeesCollection
        .doc('${int.parse(await getLastID()) + 1}')
        .set({nameFieldPath: employee.name, salaryFieldPath: employee.salary});
  }

  void editEmployee({required String id, required Employee employee}) {
    employeesCollection
        .doc(id)
        .set({nameFieldPath: employee.name, salaryFieldPath: employee.salary});
  }

  void deleteEmployee({required String id}) {
    employeesCollection.doc(id).delete();
  }

  Future<String> getLastID() async {
    return employeesCollection.get().then((value) => value.docs.last.id);
  }
}
