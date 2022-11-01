import 'package:bucket_list/bucket_list/bucket_list_model.dart';
import 'package:bucket_list/domain/bucket.dart';
import 'package:bucket_list/modules/admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BucketListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => BucketListModel()..getBucketList()),
          ChangeNotifierProvider(
              create: (context) => Admob()..createInterstitialAd()),
        ],
        child: Scaffold(
            appBar: AppBar(
              title: Center(child: Text("やりたいことリスト")),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/bucket_regist");
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 25,
                    ))
              ],
            ),
            body: Consumer<BucketListModel>(
                builder: (context, bucketListModel, child) {
              final List<Bucket>? buckets = bucketListModel.bucketList;
              if (buckets == null) {
                return CircularProgressIndicator();
              }
              return Consumer<Admob>(builder: (context, admobModel, child) {
                return ListView.builder(
                  itemCount: buckets.length,
                  itemBuilder: (_, int index) {
                    return bucketListItem(
                        context, bucketListModel, admobModel, buckets, index);
                  },
                );
              });
            })));
  }

  Widget bucketListItem(BuildContext context, BucketListModel bucketListModel, Admob admobModel,
      List<Bucket> bucketList, int index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      child: ListTile(
        leading: Text((index + 1).toString(),
            style: bucketList[index].completeFlag == "1"
                ? TextStyle(
                    fontSize: 20, decoration: TextDecoration.lineThrough)
                : TextStyle(fontSize: 20)),
        title: Text(bucketList[index].title.toString(),
            style: bucketList[index].completeFlag == "1"
                ? TextStyle(decoration: TextDecoration.lineThrough)
                : TextStyle()),
        onTap: () {
          showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: CupertinoActionSheet(
                    actions: [
                      CupertinoActionSheetAction(
                          onPressed: () {
                            bucketListModel.updCompleteFlag(
                                bucketListModel.bucketList[index]);
                            Navigator.pop(context);
                            print(admobModel.interstitialAd);
                            admobModel.showInterstitialAd();
                          },
                          child:
                              bucketListModel.bucketList[index].completeFlag ==
                                      "1"
                                  ? Text("未達成")
                                  : Text("達成")),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/bucket_update",
                              arguments: bucketList[index]);
                        },
                        child: Text("編集"),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          bucketListModel.deleteBucketList(
                              bucketListModel.bucketList[index]);
                          Navigator.pop(context);
                          admobModel.showInterstitialAd();
                        },
                        child: Text("削除"),
                      )
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      child: Text("キャンセル"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
