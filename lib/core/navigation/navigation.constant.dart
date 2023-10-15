import 'package:activity_finder/core/argument/argument.dart';
import 'package:activity_finder/ui/history/history.view.dart';
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
      case historyRoute:
        return _pageRoute(HistoryView(
          argument: settings.arguments as HistoryArgument,
        ));
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
