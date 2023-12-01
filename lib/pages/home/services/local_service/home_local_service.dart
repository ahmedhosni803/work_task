import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HomeLocalService {
  static Future<void> init() async {
    Directory? path = await getApplicationCacheDirectory();
    Hive.init(path.path);
  }

  static Future<void> saveData(
      {required String key,
      required dynamic value,
      required String poxName}) async {
    Box<dynamic> box;
    if (Hive.isBoxOpen(poxName)) {
      box = Hive.box(poxName);
    } else {
      await Hive.openBox(poxName);
      box = Hive.box(poxName);
    }
    box.put(key, value);
  }

  static Future<dynamic> getData(
      {required String key, required String poxName}) async {
    Box<dynamic> box;
    if (Hive.isBoxOpen(poxName)) {
      box = Hive.box(poxName);
    } else {
      await Hive.openBox(poxName);
      box = Hive.box(poxName);
    }
    return box.get(key);
  }
}
