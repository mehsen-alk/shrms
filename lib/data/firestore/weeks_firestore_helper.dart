import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shrms/data/firestore/paths.dart';
import '../../models/week.dart';

class WeeksFirestoreHelper {
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
    await WeekPaths.weeksCollection.get().then((QuerySnapshot weeks) async {
      for (var doc in weeks.docs) {
        Week week = Week();

        week.id = doc[WeekPaths.idFieldPath];

        week.startingDate = DateTime(
            doc[WeekPaths.startingDateFiledPath][WeekPaths.yearMapField],
            doc[WeekPaths.startingDateFiledPath][WeekPaths.monthMapField],
            doc[WeekPaths.startingDateFiledPath][WeekPaths.dayMapField]);

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

      WeekPaths.weeksCollection.doc('1').set({
        WeekPaths.idFieldPath: week.id,
        WeekPaths.startingDateFiledPath: {
          WeekPaths.yearMapField: week.startingDate?.year,
          WeekPaths.monthMapField: week.startingDate?.month,
          WeekPaths.dayMapField: week.startingDate?.day
        }
      });
    } else {
      // set week id
      week.id = _weeksList.last.id + 1;

      // set the beginning of the week
      week.startingDate =
          (await weeksList).last.startingDate?.add(const Duration(days: 7));

      await WeekPaths.weeksCollection.doc('${week.id}').set({
        WeekPaths.idFieldPath: week.id,
        WeekPaths.startingDateFiledPath: {
          WeekPaths.yearMapField: week.startingDate?.year,
          WeekPaths.monthMapField: week.startingDate?.month,
          WeekPaths.dayMapField: week.startingDate?.day
        }
      });
    }
    updateWeeksList();
  }
}
