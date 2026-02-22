import 'package:flutter/material.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_colors.dart';

import '../api/api_manager.dart';
import '../utils/app_styles.dart';
import '../utils/screen_size.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;

  const MainErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.only(top: context.height * 0.35),
      child: Column(
        spacing: context.height *0.01,
        children: [
          Text(errorMessage, style: Theme.of(context).textTheme.titleMedium),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.isLight
                  ? AppColors.blackColor
                  : AppColors.whiteColor,
            ),
            onPressed: onPressed,
            child: Text('try again', style: AppStyles.bold16white),
          ),
        ],
      ),
    );
  }
}
