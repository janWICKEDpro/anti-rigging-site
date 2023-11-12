import 'dart:typed_data';
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
      throw 'Error Occured While Uploading Image';
    }
  }
}
