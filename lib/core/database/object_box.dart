import 'dart:io';

import 'package:activity_finder/core/model/activity_box.model.dart';
import 'package:activity_finder/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

ObjectBox? database = null;

class ObjectBox {
  /// The Store of this app.
  late final Store _store;

  /// A Box of activities.
  late final Box<ActivityBox> activityBox;

  ObjectBox._create(this._store) {
    activityBox = Box<ActivityBox>(_store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<void> init() async {
    try {
      final Directory? directory = await getApplicationDocumentsDirectory();
      final store = await openStore(directory: directory?.path);

      database = ObjectBox._create(store);

      if (database?.activityBox.isEmpty() == true) {
        await database?.activityBox.putAsync(ActivityBox());
      }
    } catch (e, s) {
      debugPrint('Error initialising database: ${e.toString()}, $s');
    }
  }
}
