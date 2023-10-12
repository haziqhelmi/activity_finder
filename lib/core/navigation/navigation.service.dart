import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<NavigationService> navigationService =
    Provider<NavigationService>((_) {
  return NavigationService();
});

class NavigationService {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();
  static BuildContext? get context =>
      navigationKey.currentState?.overlay?.context;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void pop({dynamic result}) {
    return navigationKey.currentState?.pop(result);
  }
}
