import 'package:hive/hive.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_meal_entity.dart';
part 'meal_model.g.dart';

@HiveType(typeId: 1)
class MealModel {
  @HiveField(0)
  String? idMeal;
  @HiveField(1)
  String? strMeal;
  @HiveField(2)
  String? strMealThumb;

  MealModel({this.idMeal, this.strMeal, this.strMealThumb});

  MealModel.fromJson(Map<String, dynamic> json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
  }

  MealEntity toEntity() {
    return MealEntity(
      idMeal: idMeal ?? '',
      strMeal: strMeal ?? '',
      strMealThumb: strMealThumb ?? '',
    );
  }
}
