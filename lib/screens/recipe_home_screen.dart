import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/cubit/recipe_home_cubit.dart';
import 'package:reciepe_app/error/failure.dart';
import 'package:reciepe_app/services/api_service.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/recipe_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _SeafoodScreenState();
}

class _SeafoodScreenState extends State<HomeScreen> {
  late ApiService apiService;
  int _currentNavIndex = 1;

  // Currently selected category (default: Seafood, matches original screen)
  String _selectedCategory = "Seafood";

  // Future for the meals list — rebuilt whenever the category changes
  late Future<Either<Failure, List<Meal>>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    context.read<RecipeHomeCubit>().fethCategories();
    apiService = ApiService();
    _mealsFuture = apiService.getMealsByCategory(_selectedCategory);
  }

  // Called whenever the user taps a category chip
  void _onCategorySelected(String category) {
    if (category == _selectedCategory) return;
    setState(() {
      _selectedCategory = category;
      _mealsFuture = apiService.getMealsByCategory(category);
    });
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
          BlocBuilder<RecipeHomeCubit, RecipeHomeState>(
            builder: (context, state) {
              if (state is RecipeHomeLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RecipeHomeFailure) {
                return Center(child: Text(state.errorMessage));
              }
              if (state is RecipeHomeSuccess) {
                final categories = state.categories;
                return SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final item = categories[index];
                      final isSelected = item.strCategory == _selectedCategory;

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
              } else {
                return Center(child: Text('Unexpected Error'));
              }
            },
          ),
         
          const SizedBox(height: 8),
          // Meals grid — filtered by selected category
          Expanded(
            child: FutureBuilder<Either<Failure, List<Meal>>>(
              future: _mealsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  return snapshot.data!.fold(
                    (failure) => Center(
                      child: Text(
                        failure.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    (meals) {
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
                    },
                  );
                }
                return const SizedBox.shrink();
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
