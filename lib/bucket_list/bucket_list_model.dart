import 'package:bucket_list/domain/bucket.dart';
import 'package:bucket_list/domain/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BucketListModel extends ChangeNotifier {
  List<Bucket> bucketList = [];

  void getBucketList() async {
    String? userid = await User().getDeviceId();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection("buckets")
        .orderBy("regist_time", descending: false)
        .get();

    final List<Bucket> buckets = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String title = data["title"];
      final String memo = data["memo"] ?? "";
      final DateTime startTime = data["start_time"].toDate();
      final DateTime completeTime = data["complete_time"].toDate();
      final String completeFlag = data["complete_flag"];

      return Bucket(id, title, memo, startTime,
          completeTime, completeFlag);
    }).toList();

    bucketList = buckets;
    notifyListeners();
  }

  void updCompleteFlag(Bucket bucket) async{
    String? userid = await User().getDeviceId();
    if(bucket.completeFlag == "1") {
      await FirebaseFirestore.instance.collection("users").doc(userid)
          .collection("buckets").doc(bucket.id).update({
        "complete_flag" : "0"
      });
    }else {
      await FirebaseFirestore.instance.collection("users").doc(userid)
          .collection("buckets").doc(bucket.id).update({
        "complete_flag" : "1"
      });
    }
    getBucketList();
    notifyListeners();
  }

  void deleteBucketList(Bucket bucket) async{
    String? userid = await User().getDeviceId();
    await FirebaseFirestore.instance.collection("users").doc(userid)
        .collection("buckets").doc(bucket.id).delete();
    getBucketList();
    notifyListeners();
  }
}
