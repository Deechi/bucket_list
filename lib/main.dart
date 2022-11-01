import 'package:bucket_list/bucket_calendar/bucket_calendar_page.dart';
import 'package:bucket_list/bucket_list/bucket_list_page.dart';
import 'package:bucket_list/bucket_regist/bucket_regist_page.dart';
import 'package:bucket_list/bucket_update/bucket_update_page.dart';
import 'package:bucket_list/router/router_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: [const Locale("ja")],
      locale: const Locale("ja"),
      title: 'Bucket List',
      home: RouterPage(),
      initialRoute: "/",
      routes: {
        "/bucket_list": (context) => BucketListPage(),
        "/calendar": (context) => BucketCalendarPage(),
        // "/bucket_update": (context) => BucketUpdatePage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/bucket_regist":
            return PageTransition(
              child: BucketRegistPage(),
              //遷移先のページ指定
              duration: Duration(milliseconds: 250),
              //遷移スピード
              type: PageTransitionType.bottomToTop,
              //遷移のアニメーションの仕方（今回は下から上）
              settings: settings,
            );
          case "/bucket_update":
            return PageTransition(
              child: BucketUpdatePage(),
              //遷移先のページ指定
              duration: Duration(milliseconds: 250),
              //遷移スピード
              type: PageTransitionType.bottomToTop,
              //遷移のアニメーションの仕方（今回は下から上）
              settings: settings,
            );
        }
      },
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 15))),
    );
  }
}
