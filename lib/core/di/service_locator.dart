import 'package:hive/hive.dart';
import 'package:reciepe_app/core/network/api_service.dart';
import 'package:reciepe_app/feature/home/data/data_sources/local_date_source/home_local_data_source.dart';
import 'package:reciepe_app/feature/home/data/data_sources/local_date_source/home_local_data_source_imp.dart';
import 'package:reciepe_app/feature/home/data/data_sources/remote_data_source/home_remote_data_source_imp.dart';
import 'package:reciepe_app/feature/home/data/model/category_model.dart';
import 'package:reciepe_app/feature/home/data/model/meal_model.dart';
import 'package:reciepe_app/feature/home/data/model/meals_cache_model.dart';
import 'package:reciepe_app/feature/home/data/repository/home_repository_imp.dart';
import 'package:reciepe_app/feature/home/domain/use_case/home_get_category_use_case.dart';
import 'package:reciepe_app/feature/home/domain/use_case/home_get_meals_use_case.dart';
import 'package:reciepe_app/feature/home/presentation/view_model/recipe_home_cubit.dart';
import 'package:reciepe_app/feature/home/presentation/view_model/recipe_home_state.dart';

RecipeHomeCubit initCubit() {
  final apiService = ApiService();

  final remoteDataSource = HomeRemoteDataSourceImp(apiService);
  final localDataSource = HomeLocalDataSourceImpl(
    categoryBox: Hive.box<CategoryModel>("categories"),
    mealsBox: Hive.box<MealsCacheModel>("meals"),
  );
  final repository = HomeRepositoryImp(
    remoteDataSource: remoteDataSource,
    homeLocalDataSource: localDataSource,
  );

  return RecipeHomeCubit(
    HomeGetCategoryUseCase(repository),
    HomeGetMealsUseCase(repository),
    RecipeHomeInitial(),
  );
}
