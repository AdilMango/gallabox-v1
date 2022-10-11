import 'package:flutter/material.dart';

///Main App Widget
class GallaboxApp extends StatelessWidget {
  /// Creates a new instance of [GallaboxApp]
  const GallaboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gallabox',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: Scaffold(
        body: Center(
          child: Text('Gallabox'),
        ),
      ),
    );
  }
}
