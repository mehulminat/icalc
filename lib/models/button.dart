import 'package:flutter/material.dart';

class Button {
  final String value;
  final Color bgColor;
  final Color fgColor;

  Button(this.value, this.bgColor, this.fgColor);
}

List<Button> buttons = [
  Button('C', Colors.grey, Colors.black),
];
