import 'package:activity_finder/ui/shared/theme_style.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;

  const Button({
    required this.buttonText,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      highlightElevation: 0,
      focusElevation: 0,
      disabledElevation: 0,
      hoverElevation: 0,
      color: Color(0xFFF1C502),
      disabledColor: Color.fromARGB(12, 255, 255, 255),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      height: 48,
      elevation: 0,
      minWidth: MediaQuery.of(context).size.width,
      onPressed: onPressed,
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: ThemeStyle.button.copyWith(
            color: onPressed != null ? Colors.black : Color(0xFFF1C502)),
      ),
    );
  }
}
