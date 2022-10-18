import 'package:flutter/material.dart';
import 'package:gallabox/core/configs/styles/app_themes.dart';
import 'package:gallabox/features/contact/views/pages/contact_list_page.dart';

///Main App Widget
class GallaboxApp extends StatelessWidget {
  /// Creates a new instance of [GallaboxApp]
  const GallaboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallabox',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: Scaffold(
        body: Center(
          child: ContactListPage(),
        ),
      ),
    );
  }
}
