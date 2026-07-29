import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reciepe_app/models/category_model.dart';
import 'package:reciepe_app/services/api_service.dart';
part 'recipe_home_state.dart';

class RecipeHomeCubit extends Cubit<RecipeHomeState> {
  ApiService apiService;
  RecipeHomeCubit(this.apiService, super.initialState);
  Future<void> fethCategories() async {
    emit(RecipeHomeLoading());
    final result = await apiService.getCategories();
    result.fold(
      (failure)=>emit(RecipeHomeFailure(failure.errorMessage)),
      (categories)=>emit(RecipeHomeSuccess(categories)),

      );
  }
}
