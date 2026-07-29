part of 'recipe_home_cubit.dart';

@immutable
sealed class RecipeHomeState {}

class RecipeHomeInitial extends RecipeHomeState {}

class RecipeHomeLoading extends RecipeHomeState {}

class RecipeHomeSuccess extends RecipeHomeState {
  final List<CategoryModel> categories;
  RecipeHomeSuccess(this.categories);
}

class RecipeHomeFailure extends RecipeHomeState {
  final String errorMessage;
  RecipeHomeFailure(this.errorMessage );
}
