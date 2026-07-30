class Ingredient {
  final String name;
  final String measure;

  Ingredient({required this.name, required this.measure});
}

class MealDetailModel {
  String? idMeal;
  String? strMeal;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  String? strSource;
  List<Ingredient> ingredients;

  MealDetailModel({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
    this.ingredients = const [],
  });

  factory MealDetailModel.fromJson(Map<String, dynamic> json) {
    List<Ingredient> extractedIngredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        extractedIngredients.add(
          Ingredient(
            name: ingredient.toString().trim(),
            measure: measure != null ? measure.toString().trim() : '',
          ),
        );
      }
    }

    return MealDetailModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      strSource: json['strSource'],
      ingredients: extractedIngredients,
    );
  }
}
