import 'package:bucket_list/bucket_calendar/bucket_calendar_model.dart';
import 'package:bucket_list/modules/calendar/event_schedule_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BucketCalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BucketCalendarModel>(
        create: (context) => BucketCalendarModel()..getBucketList(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("カレンダー"),
          ),
          body: Consumer<BucketCalendarModel>(builder: (context, model, child) {
            if (model.eventList == null) {
              return CircularProgressIndicator();
            }
            return EventScheduleCalendar(
              dateTime: DateTime.now(),
              eventList: model.eventList,
              config: CalendarConfig(),
              onTapDay: (day) {
                showDialog<AlertDialog>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(day.dateTime.toString()),
                            ...day.eventList.map((e) => Text(e.name)),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    });
              },
            );
          }),
        ));
  }
}
