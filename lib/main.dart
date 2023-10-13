import 'dart:async';

import 'package:activity_finder/constant/value.constant.dart';
import 'package:activity_finder/core/database/object_box.dart';
import 'package:activity_finder/core/navigation/navigation.constant.dart';
import 'package:activity_finder/core/navigation/navigation.service.dart';
import 'package:activity_finder/ui/home/home.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      ObjectBox.init();
      runApp(ProviderScope(child: const MyApp()));
    },
    (e, s) {
      debugPrint('An error occurred on start-up: ${e.toString()}, $s');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ValueConstant.appName,
      theme: ThemeData.dark(useMaterial3: true),
      navigatorKey: NavigationService.navigationKey,
      initialRoute: NavConstant.homeRoute,
      onGenerateRoute: NavConstant.generateRoute,
      home: HomeView(),
    );
  }
}
