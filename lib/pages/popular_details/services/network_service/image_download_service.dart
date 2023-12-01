import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task/constants/constants.dart';

class ImageDownloadService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.imageUrl,
    validateStatus: (status) => true,
  ));

  static void downloadImage(String image) async {
    PermissionStatus status = await _getPermission();
    if (status.isGranted) {
      if (Platform.isAndroid) {
        _downloadInAndroid(image);
      }
      if (Platform.isIOS) {
        _downloadInIOS(image);
      }
    }
  }

  static Future<PermissionStatus> _getPermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      Permission.manageExternalStorage.request();
    }
    return status;
  }

  static void _downloadInAndroid(String image) async {
    String directoryPath = '/storage/emulated/0/imageTest';
    Directory directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    File file = File('$directoryPath$image');
    await _dio.download(
      image,
      file.path,
    );
  }

  static void _downloadInIOS(String image) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory('${appDocDir.path}/imageTest').createSync();

    final file = File('${appDocDir.path}/imageTest$image');
    await _dio.download(
      image,
      file.path,
    );
  }
}
