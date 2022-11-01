import 'package:bucket_list/domain/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bucket_list/bucket_update/bucket_update_model.dart';
import 'package:bucket_list/domain/bucket.dart';
import 'package:bucket_list/modules/admob.dart';

class BucketUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bucket = ModalRoute.of(context)!.settings.arguments as Bucket;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => BucketUpdateModel(bucket)),
        ChangeNotifierProvider(
            create: (context) => Admob()..createInterstitialAd()),
      ],
      child: GestureDetector(
        onTap: () => primaryFocus?.unfocus(),
        child: Consumer<BucketUpdateModel>(builder: (context, updateModel, child) {
          SizeConfig().init(context);
          final width = MediaQuery.of(context).size.width;
          return Consumer<Admob>(builder: (context, admobModel, child){
            return Scaffold(
              appBar: AppBar(
                  title: Center(child: const Text("やりたいこと編集")),
                  actions: [
                    IconButton(
                        onPressed: () {
                          updateModel.updateBucketToFirestore();
                          Navigator.pushNamed(context, "/");
                          admobModel.showInterstitialAd();
                        },
                        icon: const Icon(
                          Icons.save,
                          color: Colors.black,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Text(
                            "タイトル",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          child: TextField(
                            enabled: true,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue))),
                            controller: updateModel.titleEditContoller,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Text(
                            "期限",
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
                                child: Text(updateModel.strStartTime),
                              ),
                              onTap: () => updateModel.pickDateRange(context)),
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
                                  updateModel.strEndTime,
                                ),
                              ),
                              onTap: () => updateModel.pickDateRange(context)),
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
                              controller: updateModel.memoEditContoller,
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
