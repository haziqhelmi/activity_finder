import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:activity_finder/constant/url.constant.dart';
import 'package:activity_finder/core/model/activity.model.dart';
import 'package:activity_finder/core/network/api_request.dart';
import 'package:riverpod/riverpod.dart';

final Provider<NetworkService> networkRepository =
    Provider<NetworkService>((_) {
  return NetworkService();
});

class NetworkService extends ApiRequest {
  Future<Activity> getActivity({ActivityType? type}) async {
    Map<String, String>? param;
    if (type != null) {
      param = {
        'type': type.name,
      };
    }

    final result = await get(UrlConstant.activity, param: param);
    return Activity.fromJson(result);
  }
}
