import 'package:bhqoa/common/route/base_state.dart';
import 'package:bhqoa/resources/strings.dart';
import 'package:flutter/material.dart';
class MePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _MePageState();
}
class _MePageState extends BaseState<MePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(Strings.tab_me),
        )
      ),
    );
  }

}