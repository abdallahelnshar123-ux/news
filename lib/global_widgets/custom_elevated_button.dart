import 'package:flutter/material.dart';

import '../utils/app_Colors.dart';

class CustomElevatedButton extends StatelessWidget {
  VoidCallback onPressed;
  Widget child;
  Color backgroundColor;
  Color borderColor;

  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    this.borderColor = AppColors.transparentColor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: BorderSide(
            color: borderColor
        ),
        elevation: 0,
        minimumSize: Size(double.infinity, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}
