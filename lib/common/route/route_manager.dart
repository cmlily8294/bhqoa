import 'package:bhqoa/pages/login/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:bhqoa/home_page.dart';

typedef CupertinoPageRoute RouteBuilder(Widget page);

Route<dynamic> routeSettings(RouteSettings settings) {
  final router = RouteManager.buildRouter(settings);
  final uri = Uri.parse(settings.name);
  Route<dynamic> route = null;
  switch (uri.pathSegments[0]) {
    case 'main':
      route = router(HomePage());
      break;
    case 'login':
      route = router(LoginPage());
      break;
    default:
      return null;
  }
  return route;
}

class RouteManager {
  static const String LOGIN = "bhqoa://activity/login"; //登录
  static const String MAIN = "bhqoa://activity/main"; //首页

  static RouteBuilder buildRouter([RouteSettings settings]) {
    return (Widget page) {
      return CupertinoPageRoute(
          settings: settings,
          builder: (_) {
            return page;
          });
    };
  }

  static RouteObserver<ModalRoute> _observer;

  static List<RouteObserver> init() {
    _observer = RouteObserver<ModalRoute>();
    return [_observer];
  }

  static void subscribe(RouteAware routeAware, ModalRoute route) {
    _observer?.subscribe(routeAware, route);
  }

  static void unsubscribe(RouteAware routeAware) {
    _observer?.unsubscribe(routeAware);
  }

  static bool _isCurrentRoute(BuildContext context, String newUrl) {
    bool isNewRouteSameAsCurrent = false;

    Navigator.popUntil(context, (route) {
      if (route.settings.name == newUrl) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });

    return isNewRouteSameAsCurrent;
  }

  static Future<dynamic> route(BuildContext context, String url) {
    final uri = Uri.parse(url);
    final path = uri.pathSegments[0];
    print('route ===> ${uri.toString()}');
    switch (uri.host) {
      case 'activity':
        {
          if (path == 'login' || path == 'main') {
            if (_isCurrentRoute(context, url)) {
              return null;
            }
            return Navigator.of(context, rootNavigator: true)
                .pushNamedAndRemoveUntil(url, (route) {
              return false;
            });
          }
          return Navigator.of(context).pushNamed(url);
        }
      default:
        return null;
    }
  }
}

