import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/views/components/week_bubble.dart';

class WeeksScreen extends StatelessWidget {
  WeeksScreen({Key? key}) : super(key: key);
  static const id = 'weeksScreen';

  static List<WeekBubble> addFakeWeeks() {
    List<WeekBubble> fakeWeeks = [];
    DateTime dateTimeNow = DateTime.now();
    DateTime dateTimeAfterWeek = dateTimeNow.add(const Duration(days: 7));
    for (int i = 1; i < 6; i++) {
      fakeWeeks.add(WeekBubble(
        weekID: '$i',
        date: '${dateTimeNow.year}/${dateTimeNow.month}/${dateTimeNow.day}'
            '-> ${dateTimeAfterWeek.year}/${dateTimeAfterWeek.month}/${dateTimeAfterWeek.day}',
      ));
      dateTimeNow = dateTimeNow.add(const Duration(days: 8));
      dateTimeAfterWeek = dateTimeNow.add(const Duration(days: 7));
    }
    return fakeWeeks;
  }

  final List<WeekBubble> weeks = addFakeWeeks();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('SHRMS'),
        ),
        body: ListView(
          children: weeks,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
      ),
    );
  }
}
