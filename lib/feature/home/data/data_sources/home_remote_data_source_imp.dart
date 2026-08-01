import 'package:dio/dio.dart';
import 'package:reciepe_app/core/cache/local_cache_service.dart';
import 'package:reciepe_app/core/network/api_service.dart';
import 'package:reciepe_app/feature/home/data/data_sources/home_data_source.dart';
import 'package:reciepe_app/feature/home/data/model/category_model.dart';
import 'package:reciepe_app/feature/home/data/model/meal_model.dart';

class HomeRemoteDataSourceImp implements HomeDataSource {
  static const String _categoriesCacheKey = 'home_categories';
  static const String _mealsCachePrefix = 'home_meals_';

  ApiService apiService;
  HomeRemoteDataSourceImp(this.apiService);

  late final dio = apiService.dio;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get("/categories.php");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final jsonRes = response.data["categories"] as List;
        await LocalCacheService.put(_categoriesCacheKey, _toJsonList(jsonRes));
        final modelRes = jsonRes
            .map(((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e))))
            .toList();
        return modelRes;
      } else {
        final errorMessage = response.data["message"];
        throw Exception(errorMessage);
      }
    } on DioException {
      final cachedCategories = _getCachedList(_categoriesCacheKey);
      if (cachedCategories != null) {
        return cachedCategories
            .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      rethrow;
    }
  }

  @override
  Future<List<MealModel>> getMealsByCategory(String category) async {
    final cacheKey = '$_mealsCachePrefix$category';
    try {
      final response = await dio.get(
        "/filter.php",
        queryParameters: {"c": category},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (response.data["meals"] == null) {
          await LocalCacheService.put(cacheKey, []);
          return [];
        }
        final jsonRes = response.data["meals"] as List;
        await LocalCacheService.put(cacheKey, _toJsonList(jsonRes));
        final modelRes = jsonRes
            .map(((e) => MealModel.fromJson(Map<String, dynamic>.from(e))))
            .toList();
        return modelRes;
      } else {
        final errorMessage = response.data["message"];
        throw Exception(errorMessage);
      }
    } on DioException {
      final cachedMeals = _getCachedList(cacheKey);
      if (cachedMeals != null) {
        return cachedMeals
            .map((e) => MealModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      rethrow;
    }
  }

  List<Map<String, dynamic>> _toJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  List<dynamic>? _getCachedList(String key) {
    final cached = LocalCacheService.get(key);
    if (cached is List) return cached;
    return null;
  }
}
