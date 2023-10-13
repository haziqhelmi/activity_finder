import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Activity {
  @Id()
  int id = 0;
  int? key;
  String? activity;
  ActivityType? type;
  int? participants;
  double? price;
  double? accessibility;

  Activity({
    this.key,
    this.activity,
    this.type,
    this.participants,
    this.price,
    this.accessibility,
  });

  Activity.fromJson(Map<String, dynamic> json) {
    key = json.containsKey('key') ? int.tryParse(json['key']) : null;
    activity = json.containsKey('activity') ? json['activity'] : null;
    type = json.containsKey('type')
        ? ActivityType.values.byName(json['type'])
        : null;
    participants =
        json.containsKey('participants') ? json['participants'].toInt() : null;
    price = json.containsKey('price') ? json['price'].toDouble() : null;
    accessibility = json.containsKey('accessibility')
        ? json['accessibility'].toDouble()
        : null;
  }

  @override
  String toString() {
    return 'Activity{key: $key, activity: $activity, type: ${type?.name}, participant: $participants, price: $price, accessibility: $accessibility}';
  }
}
