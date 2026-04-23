import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKeys {
  static const String appThemeKey = 'app_theme';
  static const String onBoardingKey = 'on_boarding';
}

void saveAppTheme(int newAppTheme) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int oldAppTheme = prefs.getInt(SharedPrefsKeys.appThemeKey) ?? 1;
  if (oldAppTheme == newAppTheme) return;
  prefs.setInt(SharedPrefsKeys.appThemeKey, newAppTheme);
}
