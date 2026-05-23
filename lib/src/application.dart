import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/app_shared_pref.dart';
import 'presentation/screen/main_screen.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    AppSharedPref.initialize();
    FlutterVolumeController.updateShowSystemUI(false);
  }

  @override
  void dispose() {
    AppSharedPref.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Center',
      home: EinWrapperWidget(context: context, child: const MainScreen()),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        fontFamily: GoogleFonts.nunito().fontFamily,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
        ),
        tabBarTheme: const TabBarThemeData(labelColor: Colors.white),
        cardTheme: const CardThemeData(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
        ),
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        fontFamily: GoogleFonts.nunito().fontFamily,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
        ),
        tabBarTheme: const TabBarThemeData(labelColor: Colors.black),
        cardTheme: const CardThemeData(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
        ),
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
