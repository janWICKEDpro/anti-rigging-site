import 'package:anti_rigging/app.dart';
import 'package:anti_rigging/firebase_options.dart';
import 'package:anti_rigging/locator.dart';
import 'package:anti_rigging/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  getIt.registerSingleton(DefaultFirebaseOptions());

  await Firebase.initializeApp(
    options: getIt<DefaultFirebaseOptions>().currentPlatform,
  );
  final routes = await createRouter(isScriptsEnabled: false);
  runApp(App(
    routes: routes,
  ));
}
