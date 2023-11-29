import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:anti_rigging/locator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class Storage {
  final _dbStorage = FirebaseStorage.instance;

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

  Future<String> cacheSession() async {
    try {
      int session = math.Random().nextInt(1000000) + 1000000;
      await pref?.setString('mySessionId', session.toString());
      return session.toString();
    } catch (e) {
      throw '$e';
    }
  }

  Future<String?> getCachedSession() async {
    try {
      return pref?.getString('mySessionId');
    } catch (e) {
      throw '$e';
    }
  }
}
