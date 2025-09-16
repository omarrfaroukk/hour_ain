import 'package:flutter/material.dart';

import '../../../core/constants/app_typography.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, required this.bgcolor, required this.txt, required this.txtColor});
  final Color bgcolor;
  final String txt;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 130,
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: Text(txt, style: AppTypography.body1.copyWith(color: txtColor))),
    );
  }
}
