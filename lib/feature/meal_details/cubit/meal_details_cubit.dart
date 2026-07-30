import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/core/network/api_service.dart';
import 'package:reciepe_app/feature/meal_details/cubit/meal_details_state.dart';
import 'package:reciepe_app/feature/meal_details/services/api_service.dart';

class MealDetailsCubit extends Cubit<MealDetailsState> {
  final ApiService apiService;
  MealDetailsCubit(this.apiService) : super(MealDetailsInitial());

  Future<void> fetchMealDetails(String mealId) async {
    emit(MealDetailsLoading());
    final result = await apiService.getMealDetails(mealId);
    result.fold(
      (failure) => emit(MealDetailsFailure(failure.errorMessage)),
      (mealDetail) => emit(MealDetailsSuccess(mealDetail)),
    );
  }
}
