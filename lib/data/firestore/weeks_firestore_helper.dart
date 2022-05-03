import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shrms/models/weekly_work.dart';
import '../../models/week.dart';

class WeeksFirestoreHelper {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference weeksCollection =
      firestore.collection('Weeks');
  static const String idFieldPath = 'id';
  static const String startingDateFiledPath = 'starting date';
  static const String dayMapField = 'day';
  static const String monthMapField = 'month';
  static const String yearMapField = 'year';

  static List<Week> _weeksList = [];

  /// get the existing list or fetch it from cloud if its empty
  Future<List<Week>> get weeksList async {
    if (_weeksList.isEmpty) {
      _weeksList = await updateWeeksList();
    }

    return _weeksList;
  }

  /// fetch all weeks in firestore
  ///
  /// return a sorted list of weeks
  Future<List<Week>> updateWeeksList() async {
    // clear the existing list for avoiding duplicate data
    _weeksList = [];

    // fetch data from the cloud and but them in the list
    await weeksCollection.get().then((QuerySnapshot weeks) async {
      for (var doc in weeks.docs) {
        Week week = Week();

        week.id = doc[idFieldPath];

        week.startingDate = DateTime(
            doc[startingDateFiledPath][yearMapField],
            doc[startingDateFiledPath][monthMapField],
            doc[startingDateFiledPath][dayMapField]);

        _weeksList.add(week);
      }
    });

    // sort by id
    _weeksList.sort((e1, e2) => (e1.id > e2.id) ? 1 : 0);

    return _weeksList;
  }

  /// add week to Week firestore collection
  ///
  /// and update the existing week list
  ///
  /// id is auto increment
  ///
  /// the list will update after this
  void addWeek() async {
    Week week = Week(startingDate: DateTime.now());

    // no weeks, add the first one
    if ((await weeksList).isEmpty) {
      week.id = 1;

      // to set the beginning of the week
      List<int> eruDayWeek = [6, 7, 1, 2, 3, 4, 5];
      int daysFromFirstDayInWeek =
          -eruDayWeek.indexOf(week.startingDate!.weekday);

      week.startingDate =
          DateTime.now().add(Duration(days: daysFromFirstDayInWeek));

      weeksCollection.doc('1').set({
        idFieldPath: week.id,
        startingDateFiledPath: {
          yearMapField: week.startingDate?.year,
          monthMapField: week.startingDate?.month,
          dayMapField: week.startingDate?.day
        }
      });
    } else {
      // set week id
      week.id = _weeksList.last.id + 1;

      // set the beginning of the week
      week.startingDate =
          (await weeksList).last.startingDate?.add(const Duration(days: 7));

      await weeksCollection.doc('${week.id}').set({
        idFieldPath: week.id,
        startingDateFiledPath: {
          yearMapField: week.startingDate?.year,
          monthMapField: week.startingDate?.month,
          dayMapField: week.startingDate?.day
        }
      });
    }
    updateWeeksList();
  }

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
