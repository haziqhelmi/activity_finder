import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Activity {
  @Id()
  int? key;
  String? activity;
  ActivityType? type;
  int? participant;
  int? price;
  double? accessibility;

  Activity({
    this.key,
    this.activity,
    this.type,
    this.participant,
    this.price,
    this.accessibility,
  });
}
