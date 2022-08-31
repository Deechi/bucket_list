import 'package:bucket_list/bucket_list/bucket_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bucket List',
      home: BucketListPage(),
    );
  }
}