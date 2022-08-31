import 'package:flutter/cupertino.dart';

class BucketListModel extends ChangeNotifier {
  List<String> bucketList = ["マッサマンカレーを食べる", "筧ジュン似の女の子とsexする"];

  void upadteList() {
    bucketList[0] = "お笑いライブを見る";
    notifyListeners();
  }

}