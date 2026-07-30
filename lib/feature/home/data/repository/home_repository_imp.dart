import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciepe_app/core/error/error_handler.dart';
import 'package:reciepe_app/core/error/failure.dart';
import 'package:reciepe_app/core/exceptions/cache_exception.dart';
import 'package:reciepe_app/feature/home/data/data_sources/local_date_source/home_local_data_source.dart';
import 'package:reciepe_app/feature/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:reciepe_app/feature/home/data/model/category_model.dart';
import 'package:reciepe_app/feature/home/data/model/meal_model.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_category_entity.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_meal_entity.dart';
import 'package:reciepe_app/feature/home/domain/repository/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  // final HomeLocalDataSource<CategoryModel> _localDataSourceCategory;
  // final HomeLocalDataSource<MealModel> _localDataSourceMeal;
  final HomeLocalDataSource _homeLocalDataSource;
  HomeRepositoryImp({
    required this._remoteDataSource,
    required this._homeLocalDataSource,
  });
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final response = await _remoteDataSource.getCategories();
      final categories = response.map((e) => e.toEntity()).toList();
      await _homeLocalDataSource.cacheCategories(response);
      return right(categories);
    } on ServerException catch (e) {
      try {
        final categories = await _homeLocalDataSource.getCachedCategories();
        return right(categories.map((e) => e.toEntity()).toList());
      } on CacheException {
        return left(HandleError.handle(e.error)); // here exist error
      }
    }
  }

  @override
  Future<Either<Failure, List<MealEntity>>> getMealsByCategory(
    String category,
  ) async {
    try {
      final response = await _remoteDataSource.getMealsByCategory(category);
      final meals = response.map((e) => e.toEntity()).toList();
      await _homeLocalDataSource.cacheMeals(category, response);
      return right(meals);
    } on ServerException catch (e) {
      // return left(HandleError.handle(e));
      try {
        final meals = await _homeLocalDataSource.getCachedMeals(category);
        return right(meals.map((e) => e.toEntity()).toList());
      } on CacheException {
        return left(HandleError.handle(e.error)); // here exist error
      }
    }
  }
}
