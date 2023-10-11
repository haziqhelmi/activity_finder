import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Activity {
  @Id()
  int id = 0;
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

  Activity.fromJson(Map<String, dynamic> json) {
    key = json.containsKey('key') ? json['key'] : null;
    activity = json.containsKey('activity') ? json['activity'] : null;
    type = json.containsKey('type') ? json['type'] : null;
    participant = json.containsKey('participant') ? json['participant'] : null;
    price = json.containsKey('price') ? json['price'] : null;
    accessibility =
        json.containsKey('accessibility') ? json['accessibility'] : null;
  }
}
