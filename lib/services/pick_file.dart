import 'package:file_picker/file_picker.dart';

class FilePickerMethods {
  //pick files single
  Future<PlatformFile?> pickFile() async {
    final file = await FilePicker.platform
        .pickFiles(withData: true, type: FileType.image);
    PlatformFile finalFile = file!.files.single;
    return finalFile;
  }

  String getFileName(PlatformFile? file) {
    return file!.name.substring(0, file.name.lastIndexOf("."));
  }
}
