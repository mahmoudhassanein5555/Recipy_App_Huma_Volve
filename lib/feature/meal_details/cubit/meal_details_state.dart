import 'package:reciepe_app/feature/meal_details/models/meal_detail_model.dart';

abstract class MealDetailsState {}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsSuccess extends MealDetailsState {
  final MealDetailModel mealDetail;
  MealDetailsSuccess(this.mealDetail);
}

class MealDetailsFailure extends MealDetailsState {
  final String errorMessage;
  MealDetailsFailure(this.errorMessage);
}
