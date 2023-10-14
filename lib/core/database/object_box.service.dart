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
  Future<ActivityBox?> loadActivityBox() async {
    if (_database != null) {
      // the first object we put on ObjectBox.init() will always have id: 1,
      // and we only want to update that first object
      final dbData = await database!.activityBox.getAsync(1);

      return dbData;
    }
    return null;
  }

  Future<List<Activity>> loadAllActivities() async {
    final ActivityBox? dbData = await loadActivityBox();

    if (dbData != null) {
      final result = dbData.activities;

      return result;
    }
    return [];
  }

  Future<Activity?> loadLastActivity() async {
    final ActivityBox? dbData = await loadActivityBox();

    if (dbData != null) {
      return dbData.activities.first;
    }
    return null;
  }

  Future<String?> loadFilter() async {
    final ActivityBox? dbData = await loadActivityBox();

    if (dbData != null) {
      print(dbData);
      return dbData.lastFilterType;
    }
    return null;
  }

  /// remove

  /// save
  Future<void> saveActivity(Activity activity) async {
    final ActivityBox? dbData = await loadActivityBox();

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

  Future<void> saveFilter(String name) async {
    final ActivityBox? dbData = await loadActivityBox();

    if (dbData != null) {
      dbData.lastFilterType = name;
      saveActivityBox(dbData);
    }
  }
}
