// [SIZE] handler

import 'package:flutter/material.dart';

Widget gap(double val) {
  return SizedBox(
    height: val,
    width: val,
  );
}

Widget gapH(double val) {
  return SizedBox(
    height: val,
  );
}

Widget gapW(double val) {
  return SizedBox(
    width: val,
  );
}

double heightMQ(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double widthMQ(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// ? Sized box for height
const SizedBox gap4 = SizedBox(height: 4, width: 4);
const SizedBox gap8 = SizedBox(height: 8, width: 8);
const SizedBox gap12 = SizedBox(height: 12, width: 12);
const SizedBox gap16 = SizedBox(height: 16, width: 16);
const SizedBox gap24 = SizedBox(height: 24, width: 24);
const SizedBox gap32 = SizedBox(height: 32, width: 32);
const SizedBox gap48 = SizedBox(height: 48, width: 48);

// ? Padding all
const EdgeInsets p4 = EdgeInsets.all(4);
const EdgeInsets p8 = EdgeInsets.all(8);
const EdgeInsets p12 = EdgeInsets.all(12);
const EdgeInsets pl6 = EdgeInsets.all(16);
const EdgeInsets p24 = EdgeInsets.all(24);
const EdgeInsets p32 = EdgeInsets.all(32);
const EdgeInsets p48 = EdgeInsets.all(48);

// ? Padding horizontal
const EdgeInsets px4 = EdgeInsets.symmetric(horizontal: 4);
const EdgeInsets px8 = EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets px12 = EdgeInsets.symmetric(horizontal: 12);
const EdgeInsets px16 = EdgeInsets.symmetric(horizontal: 16);
const EdgeInsets px24 = EdgeInsets.symmetric(horizontal: 24);
const EdgeInsets px32 = EdgeInsets.symmetric(horizontal: 32);
const EdgeInsets px48 = EdgeInsets.symmetric(horizontal: 48);

// ? Padding vertical
const EdgeInsets py4 = EdgeInsets.symmetric(vertical: 4);
const EdgeInsets py8 = EdgeInsets.symmetric(vertical: 8);
const EdgeInsets pyl2 = EdgeInsets.symmetric(vertical: 12);
const EdgeInsets pyl6 = EdgeInsets.symmetric(vertical: 16);
const EdgeInsets py24 = EdgeInsets.symmetric(vertical: 24);
const EdgeInsets py32 = EdgeInsets.symmetric(vertical: 32);
const EdgeInsets py48 = EdgeInsets.symmetric(vertical: 48);
