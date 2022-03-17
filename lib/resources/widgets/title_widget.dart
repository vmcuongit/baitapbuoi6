import 'package:baitapbuoi6/resources/app_colors.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String? title;

  const TitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      color: AppColors.titleBackground,
      child: Text("$title",
          style: const TextStyle(color: AppColors.titleColor, fontSize: 18)),
    );
  }
}
