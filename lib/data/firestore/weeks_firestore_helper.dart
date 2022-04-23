import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shrms/models/weekly_work.dart';

class WeeksFirestoreHelper {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference weeksCollection = firestore.collection('Weeks');

  Stream<QuerySnapshot<Object?>> getWeeks() {
    return weeksCollection.snapshots();
  }

  /// add an empty work-week
  void addWeek() async {
    // check if the collection weeks exist if not create it
    // because there is no directly way to do that, we check if there is an document
    // in the collection by check its size
    if ((await weeksCollection.limit(1).get().then((value) => value.size)) ==
        0) {
      return weeksCollection.doc('1').set({'none': null});
    }
    await weeksCollection
        .doc('${int.parse(await getIDs().then((value) => value.last)) + 1}')
        .set({'none': null});
  }

  /// get list of weeks id
  Future<List<String>> getIDs() async {
    List<String> ids = [];
    await weeksCollection.get().then((weeks) => weeks.docs.forEach((week) {
          ids.add(week.id);
        }));
    ids.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    return ids;
  }

  /// add a work-week details for an employee
  ///
  /// the [payed] property is for determine if the employee got his receivables for this week or not
  void addEmployeeWorkWeekDetails(
      {required String weekID,
      required String employeeID,
      required WeeklyWork weeklyWork,
      bool payed = false}) {
    weeksCollection.doc(weekID).collection('Employees').doc(employeeID).set({
      'sat': weeklyWork.sat,
      'sun': weeklyWork.sun,
      'mon': weeklyWork.mon,
      'tue': weeklyWork.the,
      'wed': weeklyWork.wed,
      'the': weeklyWork.the,
      'fri': weeklyWork.fri,
      'payed': payed
    });
  }

  /// delete all employees work-week details for the given week
  void clearWeek({required String weekID}) {
    weeksCollection.doc(weekID).collection('Employees').get().then((employees) {
      employees.docs.forEach((element) {
        element.reference.delete();
      });
    });
  }
}
