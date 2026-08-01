import 'package:dio/dio.dart';
import 'package:reciepe_app/core/cache/local_cache_service.dart';
import 'package:reciepe_app/core/network/api_service.dart';
import 'package:reciepe_app/feature/meal_details/data/data_sources/meal_details_data_source.dart';
import 'package:reciepe_app/feature/meal_details/data/model/meal_detail_model.dart';

class MealDetailsRemoteDataSourceImp implements MealDetailsDataSource {
  static const String _mealDetailsCachePrefix = 'meal_details_';

  ApiService apiService;
  MealDetailsRemoteDataSourceImp(this.apiService);

  late final dio = apiService.dio;

  @override
  Future<MealDetailModel> getMealDetails(String mealId) async {
    final cacheKey = '$_mealDetailsCachePrefix$mealId';
    try {
      final response = await dio.get(
        "/lookup.php",
        queryParameters: {"i": mealId},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final jsonRes = response.data["meals"] as List;
        if (jsonRes.isEmpty) {
          throw Exception("Meal details not found");
        }
        final mealJson = Map<String, dynamic>.from(jsonRes.first);
        await LocalCacheService.put(cacheKey, mealJson);
        return MealDetailModel.fromJson(mealJson);
      } else {
        final errorMessage = response.data["message"];
        throw Exception(errorMessage);
      }
    } on DioException {
      final cachedMeal = LocalCacheService.get(cacheKey);
      if (cachedMeal is Map) {
        return MealDetailModel.fromJson(Map<String, dynamic>.from(cachedMeal));
      }
      rethrow;
    }
  }
}
