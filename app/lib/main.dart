import 'package:flutter/material.dart';

import 'router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ConceTour3DApp());
}

class ConceTour3DApp extends StatelessWidget {
  const ConceTour3DApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ConceTour 3D',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
