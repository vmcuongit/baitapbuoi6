import 'package:flutter/material.dart';

class LabelInputWidget extends StatelessWidget {
  final String? name;

  const LabelInputWidget({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("$name:", style: const TextStyle(fontSize: 16));
  }
}
