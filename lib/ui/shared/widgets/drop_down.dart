import 'package:activity_finder/constant/extension/widget.extension.dart';
import 'package:activity_finder/core/model/sheet_item.dart';
import 'package:activity_finder/ui/shared/theme_style.dart';
import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final List<SheetItem> items;
  final Function(dynamic) onItemPressed;
  final IconData? prefixIcon;
  final Function()? onPressed;

  const DropDown({
    required this.title,
    required this.controller,
    required this.items,
    required this.onItemPressed,
    this.prefixIcon,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: ThemeStyle.body1.copyWith(color: Colors.white))
            .paddingOnly(bottom: 8),
        MaterialButton(
          shape: RoundedRectangleBorder(
            side:
                BorderSide(width: 1, color: Color.fromARGB(66, 255, 255, 255)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          highlightElevation: 0,
          focusElevation: 0,
          disabledElevation: 0,
          hoverElevation: 0,
          color: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          height: 48,
          elevation: 0,
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (_) => ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    ListTile(
                      title: Text(items[i].title),
                      titleTextStyle: ThemeStyle.body1,
                      onTap: () => onItemPressed.call(items[i].metadata),
                    ),
                    Divider(height: 0, thickness: 0, indent: 16, endIndent: 16)
                  ],
                ).safeArea(),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  controller.text,
                  textAlign: TextAlign.left,
                  style: ThemeStyle.button.copyWith(color: Colors.white),
                ).paddingOnly(left: 8),
              ),
              Icon(
                prefixIcon ?? Icons.arrow_drop_down_rounded,
                size: 32,
                color: Color.fromARGB(66, 255, 255, 255),
              ).paddingOnly(left: 8),
            ],
          ),
        ),
      ],
    );
  }
}
