import 'package:flutter/material.dart';
import 'package:hour_ain/core/constants/app_colors.dart';

class JoinButton extends StatefulWidget {
  const JoinButton({super.key,  required this.ch,required this.ontap});
  final Widget ch;
  final GestureTapCallback ontap;
  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: GestureDetector(
        onTap: widget.ontap,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child:widget.ch
        ),
      ),
    );
  }
}
