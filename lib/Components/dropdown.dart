import 'package:dropdown_search/dropdown_search.dart';
import 'package:flowy_editor/Components/sizes.dart';
import 'package:flowy_editor/Components/texts.dart';
import 'package:flowy_editor/Theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDown extends StatelessWidget {
  final String hintText;
  final String fieldName;
  final String? errorText;
  final String? Function(dynamic) validator;
  final Function(dynamic)? onChange;
  final dynamic selectedValue;
  final List<dynamic> items;
  const CustomDropDown(
      {super.key,
      required this.hintText,
      required this.fieldName,
      required this.validator,
      required this.selectedValue,
      required this.items,
      this.onChange,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTexts.black16Regular(text: fieldName, context: context),
        gap4,
        DropdownSearch(
          items: items,
          selectedItem: selectedValue,
          onChanged: onChange,
          validator: validator,
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:
                GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.normal),
            dropdownSearchDecoration: InputDecoration(
              constraints: const BoxConstraints(maxWidth: 400, minWidth: 150),
              hoverColor: palette.background,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: palette.liteGrey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: palette.primary)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: palette.red)),
            ),
          ),
          popupProps: const PopupProps.menu(
            fit: FlexFit.loose,
          ),
        )
      ],
    );
  }
}

// constraints: const BoxConstraints(
//     maxHeight: 60, minHeight: 40, maxWidth: 400, minWidth: 150),

class FormDropDown extends StatelessWidget {
  final String hintText;
  final String fieldName;
  final String? errorText;
  final String? Function(dynamic) validator;
  final Function(dynamic)? onChange;
  final dynamic selectedValue;
  final List<dynamic> items;
  const FormDropDown(
      {super.key,
      required this.hintText,
      required this.fieldName,
      required this.validator,
      required this.selectedValue,
      required this.items,
      this.errorText,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTexts.black16Regular(text: fieldName, context: context),
        gap4,
        DropdownSearch(
          items: items,
          selectedItem: selectedValue,
          onChanged: onChange,
          validator: validator,
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:
                GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.normal),
            dropdownSearchDecoration: InputDecoration(
              hoverColor: palette.background,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: palette.liteGrey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: palette.primary)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: palette.red)),
            ),
          ),
          popupProps: const PopupProps.menu(
            fit: FlexFit.loose,
          ),
        )
      ],
    );
  }
}

class TemplateDropDown extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final Function(dynamic)? onChange;
  final dynamic selectedValue;
  final List<dynamic> items;
  const TemplateDropDown(
      {super.key,
      required this.hintText,
      required this.selectedValue,
      required this.items,
      this.errorText,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownSearch(
          items: items,
          selectedItem: selectedValue,
          onChanged: onChange,
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:
                GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.normal),
            dropdownSearchDecoration: InputDecoration(
              isDense: true,
              hoverColor: palette.background,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: palette.greyText, width: 1.5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: palette.secondary, width: 1.5)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: palette.red, width: 1.5)),
            ),
          ),
          popupProps: const PopupProps.menu(
            fit: FlexFit.loose,
          ),
        )
      ],
    );
  }
}
