import 'package:anti_rigging/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({super.key, this.routes});
  final GoRouter? routes;
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Anti-Rigging',
      theme: AppThemes().theme,
      routerConfig: widget.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
