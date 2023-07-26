import 'package:flutter/material.dart';
import 'package:galaxy_planets/provider/themeprovider.dart';
import 'package:galaxy_planets/views/screens/detailspage.dart';
import 'package:galaxy_planets/views/screens/homepage.dart';
import 'package:galaxy_planets/views/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/theme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool isDark = preferences.getBool('appTheme') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(
              isDark: isDark,
            ),
          ),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
            ? ThemeMode.dark
            : ThemeMode.light,
        routes: {
          '/': (context) => Splashscreen(),
          'HomePage': (context) => HomePage(),
          'detail_page': (context) => DetailPage(),
          // 'setting': (context) => SettingsPage(),
        },
      ),
    ),
  );
}
