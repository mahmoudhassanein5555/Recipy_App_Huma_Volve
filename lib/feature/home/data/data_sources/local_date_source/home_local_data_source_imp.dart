import 'package:hive/hive.dart';
import 'package:reciepe_app/core/exceptions/cache_exception.dart';
import 'package:reciepe_app/feature/home/data/data_sources/local_date_source/home_local_data_source.dart';
import 'package:reciepe_app/feature/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:reciepe_app/feature/home/data/model/category_model.dart';
import 'package:reciepe_app/feature/home/data/model/meal_model.dart';
import 'package:reciepe_app/feature/home/data/model/meals_cache_model.dart';

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final Box<CategoryModel> categoryBox;
  final Box<MealsCacheModel> mealsBox;

  HomeLocalDataSourceImpl({required this.categoryBox, required this.mealsBox});

  //==================== Categories ====================//

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    await categoryBox.clear();
    await categoryBox.addAll(categories);
  }

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    if (categoryBox.isEmpty) {
      throw CacheException("No cached categories");
    }

    return categoryBox.values.toList();
  }

  @override
  Future<void> clearCategories() async {
    await categoryBox.clear();
  }

  //==================== Meals ====================//

  @override
  Future<void> cacheMeals(String category, List<MealModel> meals) async {
    await mealsBox.put(category, MealsCacheModel(meals));
  }

  @override
  Future<List<MealModel>> getCachedMeals(String category) async {
    final cached = mealsBox.get(category);

    if (cached == null) {
      throw CacheException("No cached meals");
    }

    return cached.meals;
  }

  @override
  Future<void> clearMeals() async {
    await mealsBox.clear();
  }
}
// class LocalDataSourceImpl<T> implements HomeLocalDataSource<T> {
//   final Box<T> box;

//   LocalDataSourceImpl(this.box);

//   @override
//   Future<void> cacheData(List<T> data) async {
//     await box.clear();
//     await box.addAll(data);
//   }

//   @override
//   Future<List<T>> getCachedData() async {
//     if (box.isEmpty) {
//       throw CacheException("No cached data");
//     }

//     return box.values.toList();
//   }

//   @override
//   Future<void> clear() async {
//     await box.clear();
//   }
// }

// class HomeLocalDataSourceImpl implements HomeLocalDataSource {
//   final Box<CategoryModel> box;

//   HomeLocalDataSourceImpl(this.box);

//   @override
//   Future<void> cacheCategories(List<CategoryModel> categories) async {
//     await box.clear();

//     await box.addAll(categories);
//   }

//   @override
//   Future<void> clearCategories() async {
//     if (box.isEmpty) {
//       throw CacheException("No cached categories");
//     }

//     await box.clear();
//   }

//   @override
//   Future<List<CategoryModel>> getCachedCategories() async {
//     return box.values.toList();
//   }
// }
