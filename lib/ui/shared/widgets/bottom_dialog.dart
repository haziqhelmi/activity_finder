import 'package:activity_finder/ui/shared/style/theme_color.dart';
import 'package:activity_finder/ui/shared/style/theme_style.dart';
import 'package:flutter/material.dart';

class _BottomDialog extends StatelessWidget {
  /// title text
  final String? title;

  /// subtitle message
  final String? subtitle;

  /// primary button text (top)
  final String primaryActionText;

  /// secondary button text (bottom)
  final String? secondaryActionText;

  /// primary button callback
  final Function()? onPrimaryActionPressed;

  /// secondary button callback
  final Function()? onSecondaryActionPressed;

  const _BottomDialog({
    required this.onPrimaryActionPressed,
    required this.primaryActionText,
    this.title,
    this.subtitle,
    this.secondaryActionText,
    this.onSecondaryActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    return Center(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(maxWidth: w),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: Color(0xFF1C1C20),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitle(),
                _buildSubtitle(),
                _buildPrimaryActionButton(context),
                _buildSecondaryActionButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Visibility(
      visible: title != null,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text(
          title ?? '',
          style: ThemeStyle.subHeadingBold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Visibility(
      visible: subtitle != null,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Container(
          width: double.infinity,
          child: Text(
            subtitle ?? '',
            style: ThemeStyle.body2,
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryActionButton(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      highlightElevation: 0,
      focusElevation: 0,
      disabledElevation: 0,
      hoverElevation: 0,
      color: ThemeColor.primaryYellow,
      height: 40,
      elevation: 0,
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () => onPrimaryActionPressed?.call(),
      child: Text(
        primaryActionText,
        textAlign: TextAlign.center,
        style: ThemeStyle.button.copyWith(color: ThemeColor.black),
      ),
    );
  }

  Widget _buildSecondaryActionButton(BuildContext context) {
    return Visibility(
      visible: secondaryActionText?.isNotEmpty ?? false,
      replacement: SizedBox.shrink(),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ThemeColor.black),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        highlightElevation: 0,
        focusElevation: 0,
        disabledElevation: 0,
        hoverElevation: 0,
        color: ThemeColor.white,
        height: 40,
        elevation: 0,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => onSecondaryActionPressed?.call(),
        child: Text(
          secondaryActionText ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ThemeColor.black),
        ),
      ),
    );
  }
}

void showBottomDialog({
  required BuildContext context,
  required Function() onPrimaryActionPressed,
  required String primaryActionText,
  Function()? onSecondaryActionPressed,
  String? title,
  String? subtitle,
  String? secondaryActionText,
}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) => _BottomDialog(
      title: title,
      subtitle: subtitle,
      primaryActionText: primaryActionText,
      secondaryActionText: secondaryActionText,
      onPrimaryActionPressed: onPrimaryActionPressed,
      onSecondaryActionPressed: onSecondaryActionPressed,
    ),
  );
}
