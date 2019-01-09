import 'package:bhqoa/common/route/base_state.dart';
import 'package:bhqoa/pages/job/view/job.dart';
import 'package:bhqoa/pages/me/view/me.dart';
import 'package:bhqoa/resources/app_icons.dart';
import 'package:bhqoa/resources/styles.dart';
import 'package:bhqoa/pages/task/view/task.dart';
import 'package:bhqoa/pages/todo/view/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bhqoa/resources/strings.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {

  int _currentIndex = 0;
  List<IconData> _tabImages;
  List<String> _appBarTitles;

  List<Widget> pages = List();

   @override
  void initState() {
    super.initState();
    _initTabs();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          JobPage(),
          TodoPage(),
          TaskPage(),
          MePage()
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _appBarTitles.map((String tab) {
          return BottomNavigationBarItem(
              icon: getTabIcon(_appBarTitles.indexOf(tab)),
              title: getTabTitle(_appBarTitles.indexOf(tab)));
        }).toList(),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        }
      ),
    );
  }

  Icon getTabIcon(int currentIdx) {
    if (currentIdx == _currentIndex) {
      return Icon(_tabImages[currentIdx],
          size: 30.0, color: AppColors.blue_5276b2);
    }
    return Icon(_tabImages[currentIdx],
        size: 30.0, color: AppColors.gray_A1A7B3);
  }
  Text getTabTitle(int currentIdx) {
    if (currentIdx == _currentIndex) {
      return Text(
        _appBarTitles[currentIdx],
        style: TextStyle(
            color: AppColors.blue_5276b2, fontSize: AppFonts.font20),
      );
    }
    return Text(
      _appBarTitles[currentIdx],
      style: TextStyle(
          color: AppColors.gray_A1A7B3, fontSize: AppFonts.font20),
    );
  }

  _initTabs() {
    _tabImages = [AppIcons.tab_job, AppIcons.tab_todo, AppIcons.tab_task, AppIcons.tab_me];
    _appBarTitles = [Strings.tab_job, Strings.tab_todo, Strings.tab_task, Strings.tab_me];
  }
}