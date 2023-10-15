import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:activity_finder/core/model/activity.model.dart';

class HistoryArgument {
  final List<Activity> activities;
  final ActivityType filterType;

  HistoryArgument({
    required this.activities,
    required this.filterType,
  });
}
