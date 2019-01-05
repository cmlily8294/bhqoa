import 'package:bhqoa/common/route/base_state.dart';
import 'package:bhqoa/resources/strings.dart';
import 'package:flutter/material.dart';
class JobPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _JobPageState();
}
class _JobPageState extends BaseState<JobPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(Strings.tab_job),
        )
      ),
    );
  }

}