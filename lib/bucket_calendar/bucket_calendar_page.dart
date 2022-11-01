import 'package:bucket_list/bucket_calendar/bucket_calendar_model.dart';
import 'package:bucket_list/bucket_calendar/meeting_data_source.dart';
import 'package:bucket_list/modules/admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BucketCalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => BucketCalendarModel()..getMeetingList()),
          ChangeNotifierProvider(
              create: (context) => Admob()..createInterstitialAd()),
        ],
        child: Consumer<BucketCalendarModel>(
            builder: (context, calendarModel, child) {
          return Consumer<Admob>(builder: (context, admobModel, child) {
            return Scaffold(
              appBar: AppBar(
                  title: Center(child: const Text("カレンダー")),
                  leading:
                      calendarModel.calendarController.view == CalendarView.day
                          ? IconButton(
                              onPressed: calendarModel.changeViewToMonth,
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ))
                          : Container()),
              body: SfCalendar(
                view: CalendarView.month,
                dataSource: MeetingDataSource(calendarModel.meetingList),
                showDatePickerButton: true,
                controller: calendarModel.calendarController,
                onTap: (CalendarTapDetails calendarTapDetails) {
                  calendarModel.changeViewToDay(calendarTapDetails);
                  admobModel.showInterstitialAd();
                },
                monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                ),
              ),
            );
          });
        }));
  }
}
