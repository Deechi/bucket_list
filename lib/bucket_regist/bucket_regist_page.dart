import 'package:bucket_list/bucket_regist/bucket_regist_model.dart';
import 'package:bucket_list/domain/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bucket_list/modules/admob.dart';

class BucketRegistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => BucketRegistModel()),
        ChangeNotifierProvider(
            create: (context) => Admob()..createInterstitialAd()),
      ],
      child: GestureDetector(
        onTap: () => primaryFocus?.unfocus(),
        child: Consumer<BucketRegistModel>(builder: (context, registModel, child) {
          SizeConfig().init(context);
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;
          return Consumer<Admob>(builder: (context, admobModel, child) {
            return Scaffold(
              appBar: AppBar(
                  title: Center(child: const Text("やりたいこと登録")),
                  actions: [
                    IconButton(
                        onPressed: registModel.titleEditContoller.text == "" || registModel.startTime == null || registModel.completeTime == null
                            ? null
                            : () {
                          registModel.registBucketToFirestore();
                          Navigator.pushNamed(context, "/");
                          admobModel.showInterstitialAd();
                        },
                        icon: Icon(
                            Icons.save,
                            color: registModel.titleEditContoller.text == "" || registModel.startTime == null || registModel.completeTime == null
                                ? Colors.black26
                                : Colors.black
                        ))
                  ],
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ))),
              body: Center(
                child: Container(
                  height: SizeConfig.screenHeight! * 100,
                  width: SizeConfig.blockSizeHorizontal! * 80,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Text(
                            "タイトル   (※必須)",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          child: TextField(
                            enabled: true,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue))),
                            controller: registModel.titleEditContoller,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Text(
                            "期限   (※必須)",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, left: 20.0),
                          child: Text(
                            "開始日",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: GestureDetector(
                              child: Container(
                                width: width * 50,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                          color: Colors.blue,
                                        ))),
                                child: Text(registModel.strStartTime),
                              ),
                              onTap: () => registModel.pickDateRange(context)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Text(
                            "終了日",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: GestureDetector(
                              child: Container(
                                width: width * 50,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                          color: Colors.blue,
                                        ))),
                                child: Text(
                                  registModel.strEndTime,
                                ),
                              ),
                              onTap: () => registModel.pickDateRange(context)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Text(
                            "メモ",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                            child: TextField(
                              maxLines: 5,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                              ),
                              controller: registModel.memoEditContoller,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}
