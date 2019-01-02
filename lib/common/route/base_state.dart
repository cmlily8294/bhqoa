import 'package:bhqoa/common/route/route_manager.dart';
import 'package:flutter/material.dart';


abstract class BaseState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    RouteManager.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    RouteManager.unsubscribe(this);
    super.dispose();
  }

  bool isListenerRoute() {
    return true;
  }
}
