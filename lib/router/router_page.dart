import 'package:bucket_list/router/router_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RouterModel>(
        create: (context) => RouterModel(),
        builder: (context, snapshot) {
          return Consumer<RouterModel>(
            builder: (context, model, child) {
              return Scaffold(
                body: RouterModel.pageList[model.selectedIndex],
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.assignment_turned_in_rounded),
                      label: "やりたいことリスト"
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month),
                      label: "カレンダー"
                    ),
                  ],
                  currentIndex: model.selectedIndex,
                  selectedItemColor: Colors.amber[800],
                  onTap: model.setIndex
                ),
              );
            }
          );
        });
  }
}
