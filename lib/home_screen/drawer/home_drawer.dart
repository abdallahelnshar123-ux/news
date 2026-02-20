import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/home_screen/drawer/widget/divider_widget.dart';
import 'package:news/home_screen/drawer/widget/dropdown_widget.dart';
import 'package:news/home_screen/drawer/widget/title_widget.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_assets.dart';
import 'package:news/utils/screen_size.dart';
import 'package:provider/provider.dart';

import '../../utils/shared_prefs.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback onTap;

  late AppThemeProvider themeProviderObject;

  HomeDrawer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    themeProviderObject = Provider.of<AppThemeProvider>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          color: AppColors.whiteColor,
          width: double.infinity,
          height: context.height * 0.19,
          child: Text('News App', style: Theme.of(context).textTheme.bodyLarge),
        ),
        Padding(
          padding: EdgeInsets.all(context.width * 0.04),
          child: Column(
            children: [
              GestureDetector(
                onTap: onTap,
                child: TitleWidget(
                  icon: AppAssets.homeIcon,
                  title: context.tr('go_home'),
                ),
              ),
              DividerWidget(),
              TitleWidget(
                icon: AppAssets.themeIcon,
                title: context.tr('theme'),
              ),
              DropdownWidget(
                initialValue: context.isLight ? 'light' : 'dark',
                onSelectItem: changeTheme,
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(
                    value: 'dark',
                    label: context.tr('dark'),
                  ),
                  DropdownMenuEntry<String>(
                    value: 'light',
                    label: context.tr('light'),
                  ),
                ],
              ),
              DividerWidget(),
              TitleWidget(
                icon: AppAssets.languageIcon,
                title: context.tr('language'),
              ),
              DropdownWidget(
                initialValue: context.locale.languageCode,
                onSelectItem: (value) {
                  if (context.locale.languageCode == value) return;
                  context.setLocale(Locale(value!));
                },
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(
                    value: 'en',
                    label: context.tr('english'),
                  ),
                  DropdownMenuEntry<String>(
                    value: 'ar',
                    label: context.tr('arabic'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void changeTheme(String? newTheme) {
    themeProviderObject.changeAppTheme(
      newTheme == 'light' ? ThemeMode.light : ThemeMode.dark,
    );
    saveAppTheme(newTheme == 'light' ? 2 : 1);

    /// dark = 1    , light = 2
  }
}
