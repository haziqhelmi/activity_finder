import 'package:activity_finder/constant/extension/string.extension.dart';

enum ActivityType {
  none,
  education,
  recreational,
  social,
  diy,
  charity,
  cooking,
  relaxation,
  music,
  busywork;

  String get getName => switch (this) {
        diy => name.toUpperCase(),
        _ => name.titleCase(),
      };
}
