import 'package:flowy_editor/Components/sizes.dart';
import 'package:flowy_editor/Components/text_fields.dart';
import 'package:flowy_editor/Components/texts.dart';
import 'package:flowy_editor/Theme/palette.dart';
import 'package:flutter/material.dart';

Future templateDialog(BuildContext context,
    {required TextEditingController titleController, required Function onTap}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTexts.black16Medium(
                    context: context, text: "Save the template as"),
                gap12,
                CustomTextField(
                    fieldName: "Template Name",
                    hintText: "Template Name",
                    controller: titleController)
              ],
            ),
          ),
          actions: [
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    appTexts.black16Medium(text: "Cancel", context: context)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: palette.secondary),
                onPressed: onTap as void Function(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: appTexts.black16Medium(
                      text: "Save",
                      context: context,
                      alterColor: palette.white),
                ))
          ],
        );
      });
}
