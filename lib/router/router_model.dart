import 'package:flutter/material.dart';
import 'package:bucket_list/bucket_list/bucket_list_page.dart';
import 'package:bucket_list/bucket_calendar/bucket_calendar_page.dart';

class RouterModel extends ChangeNotifier {
  int selectedIndex = 0;
  static List<Widget> pageList = [BucketListPage(),BucketCalendarPage()];

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
