import 'package:flowy_editor/Components/sizes.dart';
import 'package:flowy_editor/Components/texts.dart';
import 'package:flowy_editor/Theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String fieldName;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatter;
  final bool? obscure;
  const CustomTextField(
      {super.key,
      required this.fieldName,
      required this.hintText,
      required this.controller,
      this.validator,
      this.obscure,
      this.formatter});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscure ?? false,
        obscuringCharacter: "*",
        textAlignVertical: TextAlignVertical.center,
        cursorWidth: 2,
        inputFormatters: formatter,
        decoration: InputDecoration(
          isDense: true,

          fillColor: palette.background,
          filled: true,
          hintStyle: GoogleFonts.roboto(
              color: Theme.of(context).colorScheme.outline, fontSize: 16),
          hintText: hintText,

          contentPadding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 15.0), // Adjust vertical padding here

          constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller, this.validator});

  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background),
      child: TextFormField(
        controller: controller,
        validator: validator,
        cursorWidth: 1,
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: GoogleFonts.roboto(
              color: Theme.of(context).colorScheme.outline,
            ),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_outlined,
              color: palette.liteGrey,
              size: 20,
            )),
      ),
    );
  }
}

class FormTextField extends StatelessWidget {
  final String fieldName;
  final String hintText;
  final int? maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatter;
  final bool? obscure;
  const FormTextField(
      {super.key,
      required this.fieldName,
      required this.hintText,
      required this.controller,
      this.validator,
      this.obscure,
      this.maxLines,
      this.formatter});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTexts.black16Regular(text: fieldName, context: context),
        gap4,
        TextFormField(
          controller: controller,
          maxLines: maxLines ?? 1,
          validator: validator,
          obscureText: obscure ?? false,
          obscuringCharacter: "*",
          textAlignVertical: TextAlignVertical.center,
          cursorWidth: 2,
          inputFormatters: formatter,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.roboto(
              color: Theme.of(context).colorScheme.outline,
            ),
            hintText: hintText,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: palette.primary,
                )),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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
      ],
    );
  }
}
