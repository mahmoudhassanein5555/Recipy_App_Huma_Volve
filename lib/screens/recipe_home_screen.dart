
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/cubit/recipe_home_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/recipe_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../core/constants/app_colors.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
 
  @override
  State<HomeScreen> createState() => _SeafoodScreenState();
}
 
class _SeafoodScreenState extends State<HomeScreen> {
  int _currentNavIndex = 1;
 
  // Currently selected category (default: Seafood, matches original screen)
  String _selectedCategory = "Seafood";
 
  // Called whenever the user taps a category chip  
  void _onCategorySelected(String category) {
    if (category == _selectedCategory) return;
    setState(() {
      _selectedCategory = category;
    });
    context.read<RecipeHomeCubit>().fetchMealsByCategory(category);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 227, 227),
      appBar: CustomAppBar(
        title: _selectedCategory,
        onMenuPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Menu tapped')));
        },
        onProfilePressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Profile tapped')));
        },
      ),
      body: Column(
        children: [
          CustomSearchBar(
            hintText: 'Search in $_selectedCategory',
            onChanged: (query) {},
          ),
 
          // ---------------- Categories (BlocBuilder) ----------------
          BlocBuilder<RecipeHomeCubit, RecipeHomeState>(
            buildWhen: (previous, current) =>
                previous.categoryStatus != current.categoryStatus ||
                previous.categories != current.categories,
            builder: (context, state) {
              switch (state.categoryStatus) {
                case CategoryStatus.initial:
                  return const SizedBox.shrink();
 
                case CategoryStatus.loading:
                  return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()),
                  );
 
                case CategoryStatus.error:
                  return SizedBox(
                    height: 50,
                    child: Center(child: Text(state.categoryErrorMessage)),
                  );
 
                case CategoryStatus.success:
                  final categories = state.categories;
                  return SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        final isSelected =
                            item.strCategory == _selectedCategory;
 
                        return ChoiceChip(
                          label: Text(item.strCategory ?? ''),
                          selected: isSelected,
                          selectedColor: AppColors.primaryBrown,
                          backgroundColor: AppColors.cardBackground,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.primaryBrown
                                  : AppColors.subtleBorder,
                            ),
                          ),
                          onSelected: (_) {
                            if (item.strCategory != null) {
                              _onCategorySelected(item.strCategory!);
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: categories.length,
                    ),
                  );
              }
            },
          ),
 
          const SizedBox(height: 8),
 
          // ---------------- Meals / Recipes (BlocBuilder) ----------------
          Expanded(
            child: BlocBuilder<RecipeHomeCubit, RecipeHomeState>(
              buildWhen: (previous, current) =>
                  previous.recipesStatus != current.recipesStatus ||
                  previous.meals != current.meals,
              builder: (context, state) {
                switch (state.recipesStatus) {
                  case RecipesStatus.initial:
                    return const SizedBox.shrink();
 
                  case RecipesStatus.loading:
                    return const Center(child: CircularProgressIndicator());
 
                  case RecipesStatus.error:
                    return Center(
                      child: Text(
                        state.recipesErrorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
 
                  case RecipesStatus.success:
                    final meals = state.meals;
                    if (meals.isEmpty) {
                      return const Center(child: Text('No recipes found'));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(
                          meal: meals[index],
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Selected: ${meals[index].strMeal}',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentNavIndex,
        onItemTapped: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }
}
 
