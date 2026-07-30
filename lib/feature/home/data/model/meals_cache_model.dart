import 'package:hive/hive.dart';
import 'meal_model.dart';

part 'meals_cache_model.g.dart';

@HiveType(typeId: 2)
class MealsCacheModel {
  @HiveField(0)
  final List<MealModel> meals;

  MealsCacheModel(this.meals);
}