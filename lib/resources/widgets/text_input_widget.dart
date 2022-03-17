import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final controller;
  final bool isNumberType;
  final focusNode;

  const TextInputWidget({
    Key? key,
    this.controller,
    required this.isNumberType,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType:
          isNumberType == true ? TextInputType.number : TextInputType.text,
    );
  }
}
