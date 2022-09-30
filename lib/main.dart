import 'package:bucket_list/bucket_list/bucket_list_page.dart';
import 'package:bucket_list/router/router_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bucket List',
      home: RouterPage()
    );
  }
}


