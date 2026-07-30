import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reciepe_app/models/category_model.dart';
import 'package:reciepe_app/services/api_service.dart';
import 'package:reciepe_app/widgets/recipe_card.dart';

part 'recipe_home_state.dart';

class RecipeHomeCubit extends Cubit<RecipeHomeState> {
  final ApiService apiService;

  RecipeHomeCubit(this.apiService) : super(RecipeHomeState.initial());

  // ---------------- Categories ----------------
  Future<void> fetchCategories() async {
    emit(state.copyWith(categoryStatus: CategoryStatus.loading));
    final result = await apiService.getCategories();
    result.fold(
      (failure) => emit(
        state.copyWith(
          categoryStatus: CategoryStatus.error,
          categoryErrorMessage: failure.errorMessage,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          categoryStatus: CategoryStatus.success,
          categories: categories,
        ),
      ),
    );
  }

  // ---------------- Recipes (Meals) ----------------
  Future<void> fetchMealsByCategory(String category) async {
    emit(state.copyWith(recipesStatus: RecipesStatus.loading));
    final result = await apiService.getMealsByCategory(category);
    result.fold(
      (failure) => emit(
        state.copyWith(
          recipesStatus: RecipesStatus.error,
          recipesErrorMessage: failure.errorMessage,
        ),
      ),
      (meals) => emit(
        state.copyWith(
          recipesStatus: RecipesStatus.success,
          meals: meals,
        ),
      ),
    );
  }
}