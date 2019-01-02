import 'package:bhqoa/common/route/base_state.dart';
import 'package:bhqoa/resources/strings.dart';
import 'package:flutter/material.dart';
class TodoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _TodoPageState();
}
class _TodoPageState extends BaseState<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(Strings.tab_todo),
        )
      ),
    );
  }

}