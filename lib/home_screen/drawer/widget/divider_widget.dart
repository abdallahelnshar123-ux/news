import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/screen_size.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.height * 0.035),
      color: AppColors.whiteColor,
      width: double.infinity,
      height: 1,
    );
  }
}
