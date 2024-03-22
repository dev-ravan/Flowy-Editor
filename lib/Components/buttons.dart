import 'package:flowy_editor/Components/texts.dart';
import 'package:flutter/material.dart';

class IconElevatedButton extends StatelessWidget {
  const IconElevatedButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.contentColor,
      required this.onTap});
  final IconData icon;
  final String title;
  final Color contentColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            fixedSize: const Size.fromHeight(50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: onTap as void Function(),
        icon: Icon(
          icon,
          color: contentColor,
          size: 24,
        ),
        label: appTexts.black16Medium(
            text: title, context: context, alterColor: contentColor));
  }
}
