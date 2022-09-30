import 'package:bucket_list/domain/bucket.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BucketListModel extends ChangeNotifier {

  List<Bucket> bucketList = [];

  void getBucketList() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users')
        .doc("WshfFG7j4ujO4ceHFYTA").collection("buckets").get();

    final List<Bucket> buckets = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String title = data["title"];
      final String memo = data["memo"];
      final DateTime registTime = data["regist_time"].toDate();
      final DateTime updateTime = data["update_time"].toDate();
      final DateTime startTime = data["start_time"].toDate();
      final DateTime completeTime = data["complete_time"].toDate();
      final String completeFlag = data["complete_flag"];
      // return Bucket(title);
      return Bucket(title, memo, registTime, updateTime,
          startTime, completeTime, completeFlag);
    }).toList();

    this.bucketList = buckets;
    notifyListeners();
  }

  void upadteList() {
  }

}