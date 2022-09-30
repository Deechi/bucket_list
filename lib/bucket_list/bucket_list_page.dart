import 'package:bucket_list/bucket_list/bucket_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bucket_list/domain/bucket.dart';

class BucketListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BucketListModel>(
        create: (context) => BucketListModel()..getBucketList(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("やりたいことリスト"),
          ),
          body: Consumer<BucketListModel>(
            builder: (context, model, child) {
              final List<Bucket>? buckets = model.bucketList;
              if(buckets == null){
                return CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: buckets.length,
                itemBuilder: (_, int index) {
                  return bucketListItem(buckets, index);
                },

              );
            }
          ),
        ));
  }
  Widget bucketListItem(List<Bucket> bucketList, int index) {
    return ListTile(
      title: Text(bucketList[index].title.toString()),
    );
  }
}
