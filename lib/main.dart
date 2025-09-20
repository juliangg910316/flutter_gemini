import 'package:flutter/material.dart';
import 'package:flutter_gemini/config/theme/app_theme.dart';

import 'config/router/app_router.dart';

void main() {
  AppTheme.setSystemUIOverlayStyle(isDarkMode: true);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarkMode: true).getTheme(),
    );
  }
}
