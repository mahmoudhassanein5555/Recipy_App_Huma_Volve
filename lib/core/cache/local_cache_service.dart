import 'package:hive_flutter/hive_flutter.dart';

class LocalCacheService {
  static const String apiCacheBoxName = 'api_cache';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(apiCacheBoxName);
  }

  static Box<dynamic> get _box => Hive.box(apiCacheBoxName);

  static Future<void> put(String key, dynamic value) async {
    if (!Hive.isBoxOpen(apiCacheBoxName)) return;
    await _box.put(key, value);
  }

  static dynamic get(String key) {
    if (!Hive.isBoxOpen(apiCacheBoxName)) return null;
    return _box.get(key);
  }
}
