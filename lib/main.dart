import 'package:bhqoa/common/route/route_manager.dart';
import 'package:bhqoa/common/security/securityService.dart';
import 'package:bhqoa/resources/styles.dart';
import 'package:flutter/material.dart';

void main() {
  SecurityService securityService= SecurityService();
  securityService.getUserInfo().then((resp) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: AppColors.blue_5276b2
      ),
      initialRoute: SecurityService().user != null ? RouteManager.MAIN : RouteManager.LOGIN,
      onGenerateRoute: routeSettings,
      navigatorObservers: RouteManager.init()
    );
  }
}
