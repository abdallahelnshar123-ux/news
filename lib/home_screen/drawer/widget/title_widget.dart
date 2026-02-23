import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/utils/screen_size.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class TitleWidget extends StatelessWidget {
  final String icon;

  final String title;

  const TitleWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.height * 0.01),
      child: Row(
        spacing: 5,
        children: [
          SvgPicture.asset(
            width: 24,
            icon,
            colorFilter: ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          Text(title, style: AppStyles.bold20white),
        ],
      ),
    );
  }
}
