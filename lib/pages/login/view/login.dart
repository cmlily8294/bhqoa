import 'package:bhqoa/common/route/base_state.dart';
import 'package:bhqoa/common/route/route_manager.dart';
import 'package:bhqoa/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {

  String _username, _password;

  final formKey = GlobalKey<FormState>();

  TextEditingController _controllerUsername, _controllerPassword;

  @override
  initState() {
    _controllerUsername = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  Future<Null> _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      RouteManager.route(context, RouteManager.MAIN);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(top: 80.0, bottom: 20.0),
              title: Text(
                '茂兰国家级自然保护区',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: AppColors.blue_5276b2),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: AppColors.blue_5276b2),
                        labelText: '用户名',
                        ),
                      validator: (val) =>
                          val.length < 1 ? '用户名不能为空' : null,
                      autovalidate: false,
                      onSaved: (val) => _username = val,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      controller: _controllerUsername,
                      autocorrect: false,
                      style: TextStyle(
                          fontSize: AppFonts.font22,
                          color: Colors.black),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: AppColors.blue_5276b2),
                        labelText: '密码'
                      ),
                      autovalidate: false,
                      validator: (val) =>
                          val.length < 6 ? '密码不能小于6位' : null,
                      obscureText: true, //输入不可见
                      onSaved: (val) => _password = val,
                      keyboardType: TextInputType.text,
                      controller: _controllerPassword,
                      autocorrect: false,
                      style: TextStyle(
                          fontSize: AppFonts.font22,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Container(
                margin: EdgeInsets.only(top: 28.0),
                child: CupertinoButton(
                  color: AppColors.blue_5276b2,
                  pressedOpacity: 0.8,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '登 录',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: AppFonts.font22,color: Colors.white),
                  ),
                  onPressed: _submit
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}