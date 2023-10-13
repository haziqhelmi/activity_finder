import 'package:flutter/widgets.dart';

/// This widget extension is for shorten and linear the code by using common widgets.

extension WidgetModifier on Widget {
  Widget paddingAll([double? value]) => Padding(
        padding: EdgeInsets.all(value ?? 24),
        child: this,
      );

  Widget paddingOnly({
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          right: right,
          top: top,
          bottom: bottom,
        ),
        child: this,
      );

  Widget paddingSymmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: this,
      );

  Widget background(Color color) => DecoratedBox(
        decoration: BoxDecoration(color: color),
        child: this,
      );

  Widget cornerRadius([BorderRadius? radius]) => ClipRRect(
        borderRadius: radius ?? BorderRadius.circular(3),
        child: this,
      );

  Widget align({AlignmentGeometry alignment = Alignment.center}) => Align(
        alignment: alignment,
        child: this,
      );

  Widget center() => Center(
        child: this,
      );

  Widget sizedBox({double? width, double? height}) => SizedBox(
        width: width,
        height: height,
        child: this,
      );

  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget safeArea({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) {
    return SafeArea(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: this,
    );
  }
}
