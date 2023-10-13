import 'package:activity_finder/constant/enum/view_state.enum.dart';
import 'package:activity_finder/core/navigation/navigation.service.dart';
import 'package:activity_finder/ui/shared/widgets/bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseController extends AutoDisposeNotifier<ViewState> {
  String? errorMsg;

  @override
  ViewState build() => ViewState.loading;

  @override
  bool updateShouldNotify(ViewState previous, ViewState next) =>
      previous != next;

  bool get isLoading => state == ViewState.loading;
  bool get isIdle => state == ViewState.idle;
  bool get isError => state == ViewState.error;

  void setLoading() => state = ViewState.loading;
  void setIdle() => state = ViewState.idle;
  void setError(
    dynamic error,
    dynamic stacktrace, {
    String? title,
    String? subtitle,
    bool noPopup = false,
  }) {
    if (state != ViewState.error) {
      state = ViewState.error;
      errorMsg = error?.toString();
      title = title ?? 'Error';
      subtitle = subtitle ?? error?.toString();
      debugPrint(
          'An error occurred in controller: ${error.toString()}, $stacktrace');

      if (!noPopup) {
        final BuildContext? context = NavigationService.context;
        if (context != null) {
          showBottomDialog(
            context: context,
            title: title,
            subtitle: subtitle,
            primaryActionText: 'Okay',
            onPrimaryActionPressed: () => Navigator.of(context).pop(),
          );
        }
      }
    }
  }
}
