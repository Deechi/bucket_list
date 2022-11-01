import 'package:bucket_list/domain/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class BucketRegistModel extends ChangeNotifier {
  DateTime? registTime;
  DateTime? startTime;
  DateTime? completeTime;
  String? completeFlag;
  String strStartTime = "";
  String strEndTime = "";
  final TextEditingController titleEditContoller = TextEditingController();
  final TextEditingController memoEditContoller = TextEditingController();

  void registBucketToFirestore() async{
    String? userid = await User().getDeviceId();
    registTime = DateTime.now();
    String id = generateID();
    FirebaseFirestore.instance.collection('users').doc(userid).collection("buckets").doc(id).set({
      "id" :  id,
      "title" : titleEditContoller.text,
      "start_time" : startTime,
      "complete_time" : completeTime,
      "memo": memoEditContoller.text,
      "regist_time" : registTime,
      "complete_flag" : "0"
    });

  }

  String generateID([int length = 20]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz';
    final random = Random.secure();
    final randomStr =  List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
    return randomStr;
  }

  void pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(hours: 24 * 3)));

    final newDateRange = await showDateRangePicker(
      initialDateRange: initialDateRange,
      context: context,
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
      builder: (context, Widget? child) => Theme(
        data: Theme.of(context).copyWith(
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
                iconTheme:
                    IconThemeData(color: Colors.black)),
            colorScheme: Theme.of(context).colorScheme.copyWith(
                onPrimary: Colors.black,
                primary: Theme.of(context).colorScheme.primary)),
        child: child!,
      ),
    );

    if (newDateRange != null) {
      DateFormat formatter = DateFormat("yyyy/MM/dd");

      startTime = newDateRange.start;
      completeTime = newDateRange.end;
      strStartTime = formatter.format(newDateRange.start);
      strEndTime = formatter.format(newDateRange.end);

      notifyListeners();
    } else {
      return;
    }
  }
}
