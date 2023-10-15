import 'package:activity_finder/constant/enum/view_state.enum.dart';
import 'package:activity_finder/constant/extension/widget.extension.dart';
import 'package:activity_finder/core/argument/argument.dart';
import 'package:activity_finder/core/model/activity.model.dart';
import 'package:activity_finder/core/navigation/navigation.service.dart';
import 'package:activity_finder/ui/history/history.controller.dart';
import 'package:activity_finder/ui/shared/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryView extends ConsumerWidget {
  final HistoryArgument argument;

  const HistoryView({
    required this.argument,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ViewState _ = ref.watch(historyController);

    return Scaffold(
      appBar: _buildAppBar(ref),
      body: _buildBody(ref),
    );
  }

  AppBar _buildAppBar(WidgetRef ref) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Color.fromARGB(255, 47, 47, 47),
      leading: IconButton(
        icon: Icon(Icons.west_rounded),
        iconSize: 24,
        onPressed: () => ref.read(navigationService).pop(),
      ),
      title: Text(
        'History',
        style: ThemeStyle.subHeadingBold,
      ),
    );
  }

  Widget _buildBody(WidgetRef ref) {
    return ListView.builder(
      itemCount: argument.activities.length,
      itemBuilder: (context, index) {
        final Activity currActivity = argument.activities[index];

        return ListTile(
          minVerticalPadding: 16,
          // contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          isThreeLine: false,
          tileColor: currActivity.getType == argument.filterType
              ? Colors.yellow.withOpacity(0.25)
              : Color.fromARGB(12, 255, 255, 255),
          title: Text(
            currActivity.activity ?? '-',
            style: ThemeStyle.subHeadingBold,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currActivity.getType.getName,
                style: ThemeStyle.body2,
              ),
              Text(
                '\$ ${currActivity.price ?? '\$ -'}',
                style: ThemeStyle.body2,
              ),
            ],
          ),
        ).paddingAll(8);
      },
    ).paddingAll(8);
  }
}
