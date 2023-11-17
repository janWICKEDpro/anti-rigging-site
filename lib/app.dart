import 'package:anti_rigging/routes/routes.dart';
import 'package:anti_rigging/utils/themes.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final routes = createRouter(isScriptsEnabled: false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Anti-Rigging',
      theme: AppThemes().theme,
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
