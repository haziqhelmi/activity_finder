import 'package:activity_finder/core/model/activity.model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ActivityBox {
  @Id()
  int id = 0;
  String lastFilterType = '';
  ToMany<Activity> activities = ToMany<Activity>();

  ActivityBox();

  @override
  String toString() {
    return 'ActivityBox{id: $id, lastFilterType: $lastFilterType, activities: $activities}';
  }
}
