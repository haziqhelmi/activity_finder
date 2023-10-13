import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:activity_finder/constant/extension/widget.extension.dart';
import 'package:activity_finder/core/model/activity.model.dart';
import 'package:activity_finder/ui/shared/theme_style.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final Activity? activity;

  const ActivityCard({
    required this.activity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String typeName =
        ActivityType.values.byName(activity?.type ?? 'none').getName;

    return Container(
      padding: EdgeInsets.all(24),
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 250),
      decoration: BoxDecoration(
        color: Color.fromARGB(12, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity?.activity ?? '-',
            style: ThemeStyle.subHeading500,
          ).paddingOnly(bottom: 4),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price', style: ThemeStyle.body2),
              Text(
                '\$ ${activity?.price ?? '-'}',
                style: ThemeStyle.body1,
              )
            ],
          ).paddingOnly(bottom: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Type', style: ThemeStyle.body2),
              Text(typeName, style: ThemeStyle.body1)
            ],
          ).paddingOnly(bottom: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Participants', style: ThemeStyle.body2),
              Text('${activity?.participants ?? '-'}', style: ThemeStyle.body1)
            ],
          ).paddingOnly(bottom: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Accessibility', style: ThemeStyle.body2),
              Text(
                '${((activity?.accessibility ?? 0) * 100).toInt()} %',
                style: ThemeStyle.body1,
              )
            ],
          ).paddingOnly(bottom: 4),
          LinearProgressIndicator(
            value: activity?.accessibility,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF1C502)),
          ),
        ],
      ),
    );
  }
}
