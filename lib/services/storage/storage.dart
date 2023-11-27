import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final _dbStorage = FirebaseStorage.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> storeImage(PlatformFile file) async {
    Uint8List fileBytes = file.bytes!;
    try {
      await _dbStorage.ref().child(file.name).putData(fileBytes);
      return await _dbStorage.ref().child(file.name).getDownloadURL();
    } catch (e) {
      log(' Error from storage $e');
      throw 'Error Occured While Uploading Image';
    }
  }

  Future cacheSession() async {
    try {
      final SharedPreferences prefs = await _prefs;
      int session = math.Random().nextInt(1000000) + 1000000;
      return await prefs.setInt('session', session);
    } catch (e) {
      throw '$e';
    }
  }

  Future<int?> getCachedSession() async {
    try {
      final SharedPreferences prefs = await _prefs;
      int session = math.Random().nextInt(1000000) + 1000000;
      return prefs.getInt('session');
    } catch (e) {
      throw '$e';
    }
  }
}
