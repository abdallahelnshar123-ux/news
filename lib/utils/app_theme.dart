import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(

    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.blackColor
    ),
    appBarTheme: AppBarTheme(
      toolbarHeight: 72,
      centerTitle: true,
      titleTextStyle: AppStyles.medium20black,
      foregroundColor: AppColors.blackColor ,
      backgroundColor: AppColors.whiteColor,
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,

    tabBarTheme: TabBarThemeData(
      tabAlignment: TabAlignment.start,
      indicatorColor: AppColors.blackColor
    ),
    textTheme: TextTheme(

      titleMedium: AppStyles.bold16black,
      titleSmall: AppStyles.medium14black,
      labelSmall: AppStyles.medium12gray,
        displayLarge: AppStyles.medium24black,
        displayMedium: AppStyles.medium24white,
      titleLarge: AppStyles.medium16black,
        bodyLarge: AppStyles.bold24black,
      headlineSmall: AppStyles.medium14white,



    ),
  );
  static final ThemeData darkTheme = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.whiteColor
    ),
    appBarTheme: AppBarTheme(
      toolbarHeight: 72,
      centerTitle: true,
      titleTextStyle: AppStyles.medium20white,
      foregroundColor: AppColors.whiteColor ,
      backgroundColor: AppColors.blackColor,
    ),
    scaffoldBackgroundColor: AppColors.blackColor,
    tabBarTheme: TabBarThemeData(
        tabAlignment: TabAlignment.start,
        indicatorColor: AppColors.whiteColor
    ),
    textTheme: TextTheme(
      titleMedium: AppStyles.bold16white,
      titleSmall: AppStyles.medium14white,
      labelSmall: AppStyles.medium12gray,
      displayLarge: AppStyles.medium24white,
      displayMedium: AppStyles.medium24black,
      titleLarge: AppStyles.medium16white,
      bodyLarge: AppStyles.bold24black,
      headlineSmall: AppStyles.medium14black,

    ),
  );
}
