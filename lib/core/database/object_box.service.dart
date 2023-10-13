import 'package:activity_finder/core/database/object_box.dart';
import 'package:activity_finder/core/model/activity.model.dart';
import 'package:activity_finder/core/model/activity_box.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ObjectBoxService> objectBoxService =
    Provider<ObjectBoxService>((_) {
  return ObjectBoxService();
});

class ObjectBoxService {
  final ObjectBox? _database = database;

  /// load
  ActivityBox? loadActivityBox() {
    if (_database != null) {
      return _database!.activityBox.get(1);
    }
    return null;
  }

  List<Activity> loadAllActivities() {
    final ActivityBox? dbData = loadActivityBox();

    if (dbData != null) {
      return dbData.activities;
    }
    return [];
  }

  String? loadFilter() {
    final ActivityBox? dbData = loadActivityBox();

    if (dbData != null) {
      return dbData.lastFilterType;
    }
    return null;
  }

  /// remove

  /// save
  void saveActivity(Activity activity) {
    final ActivityBox? dbData = loadActivityBox();

    if (dbData != null) {
      dbData.activities.add(activity);
      saveActivityBox(dbData);
    }
  }

  void saveActivityBox(ActivityBox box) {
    if (_database != null) {
      _database!.activityBox.put(box);
    }
  }

  void saveFilter(String name) {
    final ActivityBox? dbData = loadActivityBox();

    if (dbData != null) {
      dbData.lastFilterType = name;
      saveActivityBox(dbData);
      print(loadActivityBox());
    }
  }
}
