import 'package:bucket_list/domain/bucket.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bucket_list/modules/calendar/event_schedule_calendar.dart';
import 'package:flutter/material.dart';

class BucketCalendarModel extends ChangeNotifier{

  List<Event> eventList = [];

  void getBucketList() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users')
        .doc("WshfFG7j4ujO4ceHFYTA").collection("buckets").get();

    final List<Event> events = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String title = data["title"];
      final String memo = data["memo"];
      final DateTime registTime = data["regist_time"].toDate();
      final DateTime updateTime = data["update_time"].toDate();
      final DateTime startTime = data["start_time"].toDate();
      final DateTime completeTime = data["complete_time"].toDate();
      final String completeFlag = data["complete_flag"];
      // return Bucket(title);

      return Event(dateTime: startTime, name: title, color: Colors.brown);
    }).toList();

    this.eventList = events;
    notifyListeners();

  }
}