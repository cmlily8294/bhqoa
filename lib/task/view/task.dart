import 'package:bhqoa/common/route/base_state.dart';
import 'package:bhqoa/resources/strings.dart';
import 'package:flutter/material.dart';
class TaskPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _TaskPageState();
}
class _TaskPageState extends BaseState<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(Strings.tab_task),
        )
      ),
    );
  }

}