import 'package:baitapbuoi6/resources/app_colors.dart';
import 'package:flutter/material.dart';

TextStyle textButtonMainStyle = TextStyle(
    color: AppColors.buttonColor, fontSize: 16, fontWeight: FontWeight.bold);

ButtonStyle buttonDefaultStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(Colors.white),
    padding: MaterialStateProperty.all(
        const EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 18)));

ButtonStyle buttonMainStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.buttonBg),
    padding: MaterialStateProperty.all(
        const EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 18)));
