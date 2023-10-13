import 'package:activity_finder/ui/home/home.view.dart';
import 'package:flutter/material.dart';

class NavConstant {
  NavConstant();

  static const String historyRoute = '/history';
  static const String homeRoute = '/home';

  static MaterialPageRoute _pageRoute(
    Widget page, {
    bool isFullscreenDialog = false,
  }) {
    return MaterialPageRoute(
        builder: (_) => page, fullscreenDialog: isFullscreenDialog);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _pageRoute(HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
              body: Center(
            child: Text('No route found: ${settings.name}'),
          )),
        );
    }
  }
}
