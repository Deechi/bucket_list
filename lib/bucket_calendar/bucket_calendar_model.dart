import 'package:bucket_list/domain/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bucket_list/domain/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BucketCalendarModel extends ChangeNotifier{

  final CalendarController calendarController = CalendarController();
  List<Meeting> meetingList = [];

  void getMeetingList() async {
    String? userid = await User().getDeviceId();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users')
        .doc(userid).collection("buckets").get();

    final List<Meeting> events = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String title = data["title"];
      final DateTime startTime = data["start_time"].toDate();
      final DateTime completeTime = data["complete_time"].toDate();
      final String completeFlag = data["complete_flag"];

      if(completeFlag == "1") {
        return Meeting(title, startTime, completeTime, Colors.black45, true);
      }else {
        return Meeting(title, startTime, completeTime, Colors.blue, true);
      }

    }).toList();

    meetingList = events;
    notifyListeners();

  }

  void changeViewToDay(CalendarTapDetails calendarTapDetails) {
    if(calendarController.view == CalendarView.month && calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      calendarController.view = CalendarView.day;
      notifyListeners();
    }
  }

  void changeViewToMonth() {
    calendarController.view = CalendarView.month;
    notifyListeners();
  }

}