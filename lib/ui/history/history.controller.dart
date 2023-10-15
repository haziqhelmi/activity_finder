import 'package:activity_finder/constant/enum/view_state.enum.dart';
import 'package:activity_finder/ui/shared/base.controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyController =
    AutoDisposeNotifierProvider<HistoryController, ViewState>(() {
  return HistoryController();
});

class HistoryController extends BaseController {}
