import 'package:assignment/config/theme/colors.dart';
import 'package:flutter/material.dart';

class MyDecoration {
  static const BoxDecoration decoration = BoxDecoration(
      color: Color.fromRGBO(246, 246, 246, 1),
      boxShadow: [
        BoxShadow(color: Colors.white, offset: Offset(10, 10), blurRadius: 10),
        BoxShadow(color: Colors.white, offset: Offset(-10, -10), blurRadius: 10)
      ],
      borderRadius: BorderRadius.all(Radius.circular(20)));

  static const BoxDecoration darkdecoration = BoxDecoration(
      color: AppColors.dark,
      boxShadow: [
        BoxShadow(
            color: AppColors.dark, offset: Offset(10, 10), blurRadius: 10),
        BoxShadow(
            color: AppColors.dark, offset: Offset(-10, -10), blurRadius: 10)
      ],
      gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.bottomLeft,
        colors: [
          AppColors.dark,
          AppColors.lightGrey,
        ],
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)));
}
