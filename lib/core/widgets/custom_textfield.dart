import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.mycontroller,
    required this.label,
    this.val
  });

  final TextEditingController mycontroller;
  final String label;
  final String? Function(String?)? val;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                label,
                style: AppTypography.body2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          TextFormField(
            validator: val,
            cursorColor: AppColors.secondaryColor,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.whiteColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 2.3,
                  color: AppColors.primaryColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 1.3,
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width:2.5,
                  color: Colors.red,
                ),
              ),
              errorStyle: AppTypography.caption1.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              filled: true,
              fillColor: AppColors.transparentwo,
            ),
            controller: mycontroller,
            style: AppTypography.body2.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(183, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
