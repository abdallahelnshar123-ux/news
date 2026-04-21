import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/home_screen/home_screen.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/provider/source_provider.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/app_theme.dart';
import 'package:news/utils/shared_prefs.dart';
import 'package:news/webview_screen/webview_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final int appTheme =
      sharedPreferences.getInt(SharedPrefsKeys.appThemeKey) ?? 1;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppThemeProvider(
            appTheme: appTheme == 1 ? ThemeMode.dark : ThemeMode.light,
          ),
        ),
        ChangeNotifierProvider(create: (context) => SourceProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        saveLocale: true,
        fallbackLocale: Locale('en'),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProviderObject = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.webviewRouteName: (context) => WebViewScreen(),
      },
      theme: AppTheme.lightTheme,
      themeMode: themeProviderObject.appTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
