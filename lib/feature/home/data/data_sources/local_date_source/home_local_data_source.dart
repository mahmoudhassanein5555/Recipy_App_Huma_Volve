// import 'package:reciepe_app/feature/home/data/model/category_model.dart';

// abstract class HomeLocalDataSource<T> {
//   Future<void> cacheData(List<T> data);

//   Future<List<T>> getCachedData();

//   Future<void> clear();
// }
import 'package:reciepe_app/feature/home/data/model/category_model.dart';
import 'package:reciepe_app/feature/home/data/model/meal_model.dart';

abstract class HomeLocalDataSource {
  // Categories
  Future<void> cacheCategories(List<CategoryModel> categories);

  Future<List<CategoryModel>> getCachedCategories();

  Future<void> clearCategories();

  // Meals
  Future<void> cacheMeals(String category, List<MealModel> meals);

  Future<List<MealModel>> getCachedMeals(String category);

  Future<void> clearMeals();
}
