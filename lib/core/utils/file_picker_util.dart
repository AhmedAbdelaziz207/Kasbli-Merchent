import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  /// This class is used to pick files from the device.
  FilePickerUtil._();

  static FilePickerUtil instance = FilePickerUtil._();

    final FilePicker _filePicker = FilePicker.platform;

  Future<File?> pick(PickType pickType) async {
    if (pickType == PickType.file) {
      final result = await _filePicker.pickFiles(type: FileType.any);
      if (result != null) {
        return File(result.files.single.path!);
      }
      return null;
    }

    if (pickType == PickType.image) {
      final result = await _filePicker.pickFiles(type: FileType.image);
      if (result != null) {
        return File(result.files.single.path!);
      }
      return null;
    }

    if (pickType == PickType.video) {
      final result = await _filePicker.pickFiles(type: FileType.video);
      if (result != null) {
        return File(result.files.single.path!);
      }
      return null;
    }

    return null;
  }
}

enum PickType { image, video, file }
