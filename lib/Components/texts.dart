// ignore_for_file: deprecated_member_use

import 'package:flowy_editor/Theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTexts = AppTexts();

class AppTexts {
  Text navLogo() {
    return Text(
      "atre",
      style: GoogleFonts.jost(
          color: palette.primary, fontWeight: FontWeight.w500, fontSize: 70),
    );
  }

  Text appLogo() {
    return Text(
      "atre",
      style: GoogleFonts.jost(
          color: palette.primary, fontWeight: FontWeight.w400, fontSize: 50),
    );
  }

// ! Black color 16 roboto regular weight
  Text black16Regular(
          {required String text, BuildContext? context, Color? alterColor}) =>
      Text(
        text,
        style: GoogleFonts.roboto(
          color: alterColor ?? Theme.of(context!).colorScheme.scrim,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      );

  // ! Roboto color 16 roboto regular weight
  Text black16Medium(
          {required String text,
          required BuildContext context,
          Color? alterColor}) =>
      Text(
        text,
        style: GoogleFonts.roboto(
          color: alterColor ?? Theme.of(context).colorScheme.scrim,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      );

  // ! Roboto color 14 roboto medium weight
  Text black14Medium(
          {required String text,
          required BuildContext context,
          Color? alterColor}) =>
      Text(
        text,
        style: GoogleFonts.roboto(
          color: alterColor ?? Theme.of(context).colorScheme.scrim,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );

  // ! Roboto color 14 roboto regular weight
  Text roboto14Regular({required String text, Color? alterColor}) => Text(
        text,
        style: GoogleFonts.roboto(
          color: alterColor ?? palette.greyText,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      );

  // ! Roboto color 10 roboto bold weight
  Text roboto10Bold({required String text, required Color textColor}) => Text(
        text,
        style: GoogleFonts.roboto(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      );

// ! Black color 28 roboto regular weight
  Text black28Regular(
          {required String text,
          required BuildContext context,
          Color? alterColor}) =>
      Text(
        text,
        style: GoogleFonts.roboto(
          color: alterColor ?? Theme.of(context).colorScheme.scrim,
          fontSize: 28,
          fontWeight: FontWeight.w500,
        ),
      );

  // ! White color 16 roboto medium weight
  Text white16Med({required String text, required BuildContext context}) =>
      Text(
        text,
        style: GoogleFonts.roboto(
          color: Theme.of(context).colorScheme.background,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      );

  // ! White color 16 roboto medium weight
  Text black20Med({required String text, required BuildContext context}) =>
      Text(
        text,
        style: GoogleFonts.roboto(
          color: Theme.of(context).colorScheme.scrim,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      );

// ! Black color 32 roboto medium weight
  Text black32Med(
          {required String text,
          required BuildContext context,
          Color? alterColor}) =>
      Text(
        text,
        style: GoogleFonts.roboto(
          color: alterColor ?? Theme.of(context).colorScheme.scrim,
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
      );

// ! Grey color 18 roboto regular weight
  Text grey18Regular({required String text}) => Text(
        text,
        style: GoogleFonts.roboto(
          color: palette.liteGrey,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      );

// ! Black color 18 roboto regular weight
  Text black20({required String text}) => Text(
        text,
        style: GoogleFonts.roboto(
          color: palette.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      );

  // ! Black color 12 roboto regular weight
  Text black12Regular({required String text, required BuildContext context}) =>
      Text(
        text,
        style: GoogleFonts.roboto(
          color: Theme.of(context).colorScheme.scrim,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      );

  // ! Green color 12 roboto regular weight
  Text green12Regular({required String text, required BuildContext context}) =>
      Text(
        text,
        style: GoogleFonts.roboto(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      );
}
