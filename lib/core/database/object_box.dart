import 'dart:io';

import 'package:activity_finder/core/model/activity.model.dart';
import 'package:activity_finder/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store _store;

  /// A Box of activities.
  late final Box<Activity> _activityBox;

  ObjectBox._create(this._store) {
    _activityBox = Box<Activity>(_store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Note: setting a unique directory is recommended if running on desktop
    // platforms. If none is specified, the default directory is created in the
    // users documents directory, which will not be unique between apps.
    // On mobile this is typically fine, as each app has its own directory
    // structure.

    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final Directory? directory = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: directory?.path);

    return ObjectBox._create(store);
  }

  // Stream<List<Note>> getNotes() {
  //   // Query for all notes, sorted by their date.
  //   // https://docs.objectbox.io/queries
  //   final builder = _noteBox.query().order(Note_.date, flags: Order.descending);
  //   // Build and watch the query,
  //   // set triggerImmediately to emit the query immediately on listen.
  //   return builder
  //       .watch(triggerImmediately: true)
  //       // Map it to a list of notes to be used by a StreamBuilder.
  //       .map((query) => query.find());
  // }

  /// Add a note.
  ///
  /// To avoid frame drops, run ObjectBox operations that take longer than a
  /// few milliseconds, e.g. putting many objects, asynchronously.
  /// For this example only a single object is put which would also be fine if
  /// done using [Box.put].
  Future<void> addNote(Activity data) => _activityBox.putAsync(data);

  Future<void> removeNote(int id) => _activityBox.removeAsync(id);
}
