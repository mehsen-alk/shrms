import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/weeks_firestore_helper.dart';
import 'package:shrms/views/components/week_bubble.dart';

import '../../../models/week.dart';

class WeeksScreen extends StatefulWidget {
  const WeeksScreen({Key? key}) : super(key: key);
  static const id = 'weeksScreen';

  @override
  State<WeeksScreen> createState() => _WeeksScreenState();
}

class _WeeksScreenState extends State<WeeksScreen> {
  final WeeksFirestoreHelper _helper = WeeksFirestoreHelper();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('SHRMS'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await _helper.updateWeeksList();
            setState(() {});
          },
          child: FutureBuilder<List<Week>>(
            future: _helper.weeksList,
            builder: _futureBuilder,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add),
          onPressed: () {
            _helper.addWeek();
          },
        ),
      ),
    );
  }

  Widget _futureBuilder(BuildContext context, AsyncSnapshot<List<Week>> weeks) {
    List<WeekBubble> weeksBubble = [];

    if (weeks.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (weeks.connectionState == ConnectionState.done) {
      if (weeks.hasData) {
        weeks.data?.forEach((week) {
          weeksBubble.add(WeekBubble(week: week));
        });
        if (weeksBubble.isNotEmpty) {
          return ListView(
            shrinkWrap: true,
            children: weeksBubble,
          );
        } else {
          return const Center(child: Text('no data'));
        }
      }
    }
    return const Text('error');
  }
}
