import 'package:anti_rigging/app.dart';
import 'package:anti_rigging/firebase_options.dart';
import 'package:anti_rigging/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  getIt.registerSingleton(DefaultFirebaseOptions());

  await Firebase.initializeApp(
    options: getIt<DefaultFirebaseOptions>().currentPlatform,
  );
  runApp(const App());
}
