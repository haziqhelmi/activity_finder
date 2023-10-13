// import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:activity_finder/constant/enum/view_state.enum.dart';
import 'package:activity_finder/core/model/activity.model.dart';
import 'package:activity_finder/core/navigation/navigation.service.dart';
import 'package:activity_finder/core/network/network.service.dart';
import 'package:activity_finder/ui/shared/base.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeController =
    AutoDisposeNotifierProvider<HomeController, ViewState>(() {
  return HomeController();
});

class HomeController extends BaseController {
  late final NavigationService _navigationService;
  late final NetworkService _networkService;

  @override
  ViewState build() {
    ref.onDispose(() => dropdownController.dispose());
    _navigationService = ref.read(navigationService);
    _networkService = ref.read(networkService);

    return ViewState.loading;
  }

  final TextEditingController dropdownController = TextEditingController();
  Activity? currActivity;

  Future<void> init() async {
    try {
      // fetch last filter -> set text to controller
      // fetch last activity -> set currActivity
      // else show empty '-'
      dropdownController.text = ActivityType.none.getName;
      currActivity = await _networkService.getActivity();
      print(currActivity.toString());
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  Future<void> onNextPressed() async {
    setLoading();
    try {
      currActivity = await _networkService.getActivity();
      // if (currActivity?.type == ActivityType.diy) {
      //   setIdle();
      // } else {
      //   // PART 3: call the api again if condition is not satisfied
      //   // the better way is to pass in a parameter `type` into the api call
      //   await onNextPressed();
      // }
      print(currActivity.toString());
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  void onTypeSelected(ActivityType type) {
    setLoading();
    dropdownController.text = type.getName;
    _navigationService.pop();
    setIdle();
  }
}
