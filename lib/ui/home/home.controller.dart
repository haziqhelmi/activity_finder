import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:activity_finder/constant/enum/view_state.enum.dart';
import 'package:activity_finder/core/argument/argument.dart';
import 'package:activity_finder/core/database/object_box.service.dart';
import 'package:activity_finder/core/model/activity.model.dart';
import 'package:activity_finder/core/navigation/navigation.constant.dart';
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
  late final ObjectBoxService _objectBoxService;
  late final NavigationService _navigationService;
  late final NetworkService _networkService;

  @override
  ViewState build() {
    ref.onDispose(() => dropdownController.dispose());
    _objectBoxService = ref.read(objectBoxService);
    _navigationService = ref.read(navigationService);
    _networkService = ref.read(networkService);

    return ViewState.loading;
  }

  final TextEditingController dropdownController = TextEditingController();
  List<Activity> activities = [];
  Activity? currActivity;
  Activity? prevActivity;

  Future<void> init() async {
    try {
      // fetch last filter -> set text to controller
      final String? savedFilter = await _objectBoxService.loadFilter();
      if (savedFilter != null && savedFilter.isNotEmpty) {
        dropdownController.text =
            ActivityType.values.byName(savedFilter).getName;
      } else {
        dropdownController.text = ActivityType.none.getName;
      }

      // fetch last activity -> set currActivity
      activities = await _objectBoxService.loadAllActivities();
      if (activities.isNotEmpty) {
        currActivity = activities.last;
        if (activities.length >= 2) {
          prevActivity = activities.elementAt(activities.length - 2);
        }
      }

      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  void navigateToHistory() {
    final HistoryArgument argument = HistoryArgument(
      activities: activities,
      filterType: ActivityType.values.byName(
        dropdownController.text.toLowerCase(),
      ),
    );
    _navigationService.navigateTo(
      NavConstant.historyRoute,
      arguments: argument,
    );
  }

  Future<void> onSearchPressed() async {
    setLoading();
    try {
      currActivity = await _networkService.getActivity();
      debugPrint('currActivity: $currActivity');

      final ActivityType selectedType =
          ActivityType.values.byName(dropdownController.text.toLowerCase());
      final bool keepSearching = selectedType != ActivityType.none &&
          selectedType.name != currActivity?.type;

      if (keepSearching) {
        // PART 3: call the api again if condition is not satisfied
        // the better way is to pass in a parameter `type` into the api call
        await onSearchPressed();
      } else {
        if (currActivity != null) {
          await _objectBoxService.saveActivity(currActivity!);
        }
        activities = await _objectBoxService.loadAllActivities();
        setIdle();
      }

      if (activities.length >= 2) {
        prevActivity = activities.elementAt(activities.length - 2);
      }
    } catch (e, s) {
      setError(e, s);
    }
  }

  void onTypeSelected(ActivityType type) {
    setLoading();
    dropdownController.text = type.getName;
    _objectBoxService.saveFilter(type.name);
    _navigationService.pop();
    setIdle();
  }
}
