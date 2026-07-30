part of 'recipe_home_cubit.dart';

// حالة الكاتيجوري لوحدها
enum CategoryStatus { initial, loading, success, error }

// حالة الـ Recipes لوحدها
enum RecipesStatus { initial, loading, success, error }

@immutable
class RecipeHomeState {
  // Category part
  final CategoryStatus categoryStatus;
  final List<CategoryModel> categories;
  final String categoryErrorMessage;

  // Recipes part
  final RecipesStatus recipesStatus;
  final List<Meal> meals;
  final String recipesErrorMessage;

  const RecipeHomeState({
    this.categoryStatus = CategoryStatus.initial,
    this.categories = const [],
    this.categoryErrorMessage = '',
    this.recipesStatus = RecipesStatus.initial,
    this.meals = const [],
    this.recipesErrorMessage = '',
  });

  factory RecipeHomeState.initial() => const RecipeHomeState();

  RecipeHomeState copyWith({
    CategoryStatus? categoryStatus,
    List<CategoryModel>? categories,
    String? categoryErrorMessage,
    RecipesStatus? recipesStatus,
    List<Meal>? meals,
    String? recipesErrorMessage,
  }) {
    return RecipeHomeState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categories: categories ?? this.categories,
      categoryErrorMessage: categoryErrorMessage ?? this.categoryErrorMessage,
      recipesStatus: recipesStatus ?? this.recipesStatus,
      meals: meals ?? this.meals,
      recipesErrorMessage: recipesErrorMessage ?? this.recipesErrorMessage,
    );
  }
}