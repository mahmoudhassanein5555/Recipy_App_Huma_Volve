import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reciepe_app/core/constants/app_colors.dart';
import 'package:reciepe_app/core/di/service_locator.dart';
import 'package:reciepe_app/core/network/api_service.dart';
import 'package:reciepe_app/feature/home/data/data_sources/local_date_source/home_local_data_source.dart';
import 'package:reciepe_app/feature/home/data/data_sources/local_date_source/home_local_data_source_imp.dart';
import 'package:reciepe_app/feature/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:reciepe_app/feature/home/data/data_sources/remote_data_source/home_remote_data_source_imp.dart';
import 'package:reciepe_app/feature/home/data/model/category_model.dart';
import 'package:reciepe_app/feature/home/data/model/meal_model.dart';
import 'package:reciepe_app/feature/home/data/model/meals_cache_model.dart';
import 'package:reciepe_app/feature/home/data/repository/home_repository_imp.dart';
import 'package:reciepe_app/feature/home/domain/repository/home_repository.dart';
import 'package:reciepe_app/feature/home/domain/use_case/home_get_category_use_case.dart';
import 'package:reciepe_app/feature/home/domain/use_case/home_get_meals_use_case.dart';
import 'package:reciepe_app/feature/home/presentation/view_model/recipe_home_cubit.dart';
import 'package:reciepe_app/feature/home/presentation/view_model/recipe_home_state.dart';
import 'package:reciepe_app/feature/home/presentation/view/recipe_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(MealModelAdapter());
  Hive.registerAdapter(MealsCacheModelAdapter());

  await Hive.openBox<MealsCacheModel>("meals");
  await Hive.openBox<CategoryModel>("categories");
  // await Hive.openBox<MealModel>("meals");
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBrown,
          surface: AppColors.background,
        ),
        fontFamily: 'Roboto',
      ),
      // home: const SeafoodScreen(),
      home: BlocProvider(create: (context) => initCubit(), child: HomeScreen()),
    );
  }
}
    // final ApiService apiService = ApiService();
    // final categoryBox = Hive.box<CategoryModel>("categories");
    // final mealBox = Hive.box<MealModel>("meals");
    // final HomeLocalDataSource homeLocalDataSource =  HomeGetCategoryUseCase<CategoryModel>(
    //   categoryBox,
    // );
    // final HomeRemoteDataSource homeRemoteDataSource = HomeRemoteDataSourceImp(
    //   apiService,
    // );

    // // final categoryBox =  Hive.openBox<CategoryModel>("categories");
    // final HomeRepository homeRepository = HomeRepositoryImp(
    //   remoteDataSource: homeRemoteDataSource,
    //   localDataSourceCategory: homeLocalDataSource,
    // );
    // final HomeGetCategoryUseCase homeGetCategoryUseCase =
    //     HomeGetCategoryUseCase(homeRepository);
    // final HomeGetMealsUseCase homeGetMealsUseCase = HomeGetMealsUseCase(
    //   homeRepository,
    // );
    // final RecipeHomeCubit recipeHomeCubit = RecipeHomeCubit(
    //   homeGetCategoryUseCase,
    //   homeGetMealsUseCase,
    //   RecipeHomeInitial(),
    // );
