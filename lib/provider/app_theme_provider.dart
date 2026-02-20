import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme;

  AppThemeProvider({required this.appTheme});
  void changeAppTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) return;

    appTheme = newTheme;
    notifyListeners();
  }

  bool isLight() {
    return appTheme == ThemeMode.light ? true : false;
  }
}

extension AppThemeExtension on BuildContext {
  bool get isLight => Provider.of<AppThemeProvider>(this).isLight();
}
