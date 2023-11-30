import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task/constant/constant_api.dart';

class DownloadMange {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConst.imageUrl,
    validateStatus: (status) => true,
  ));

  static imageDownload(String image) async {
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

  static _downloadInAndroid(String image) async {
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

  static _downloadInIOS(String image) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory('${appDocDir.path}/imageTest').createSync();

    final file = File('${appDocDir.path}/imageTest$image');
    await _dio.download(
      image,
      file.path,
    );
  }
}
