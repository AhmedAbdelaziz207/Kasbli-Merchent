import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';

import '../network/api_endpoints.dart';
import '../network/dio_factory.dart';

class ImageDownloader {
  /// Download multiple images from a list of URLs
  static Future<bool> downloadImages(List<String> imageUrls) async {
    try {
      final dir = await getTemporaryDirectory();

      for (int i = 0; i < imageUrls.length; i++) {
        final url = ApiEndPoints.baseUrl + imageUrls[i];

        log("📥 Downloading image ${i + 1}/${imageUrls.length} from $url");

        final Response<List<int>> image = await DioFactory.getDio().get<List<int>>(
          url,
          options: Options(responseType: ResponseType.bytes),
        );

        final filePath = '${dir.path}/image_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
        final file = File(filePath);
        await file.writeAsBytes(image.data!);

        // Ask the user to save each file
        final params = SaveFileDialogParams(sourceFilePath: file.path);
        final finalPath = await FlutterFileDialog.saveFile(params: params);

        if (finalPath != null) {
          log("✅ Image ${i + 1} saved at $finalPath");
        } else {
          log("❌ Image ${i + 1} save canceled by user");
        }
      }

      return true;
    } catch (e, stack) {
      log("❌ Image Download Failed: $e");
      log(stack.toString());
      return false;
    }
  }
}
