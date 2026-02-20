import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_theme_provider.dart';

typedef OnSelectItem = void Function(String?)?;

class DropdownWidget extends StatelessWidget {
  final OnSelectItem onSelectItem;

  final String initialValue;

  final List<DropdownMenuEntry<String>> dropdownMenuEntries;
  late AppThemeProvider themeProviderObject;

  DropdownWidget({
    super.key,
    required this.dropdownMenuEntries,
    required this.onSelectItem,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    themeProviderObject = Provider.of<AppThemeProvider>(context);

    return DropdownMenu(
      initialSelection: initialValue,
      onSelected: onSelectItem,
      textStyle: AppStyles.medium16white,
      dropdownMenuEntries: dropdownMenuEntries,
      width: double.infinity,
      enableSearch: false,
      showTrailingIcon: true,

      /// menu style =================================================
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            // side: BorderSide(color: AppColors.blackColor),
          ),
        ),
      ),

      /// field border decoration ===========================================
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: AppColors.whiteColor,
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),

      /// icon when it is closed ============================================
      trailingIcon: Icon(
        Icons.arrow_drop_down_rounded,
        size: 50,
        color: AppColors.whiteColor,
      ),

      /// icon when it is opened ============================================
      selectedTrailingIcon: Icon(
        Icons.arrow_drop_up_rounded,
        size: 50,
        color: AppColors.whiteColor,
      ),
    );
  }
}
