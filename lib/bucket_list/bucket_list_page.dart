import 'package:bucket_list/bucket_list/bucket_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BucketListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BucketListModel>(
        create: (context) => BucketListModel(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("やりたいことリスト"),
          ),
          body: Center(),
        ));
  }
}
