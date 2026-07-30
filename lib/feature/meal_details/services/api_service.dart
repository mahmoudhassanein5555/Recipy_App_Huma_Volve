// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:reciepe_app/core/error/error_handler.dart';
// import 'package:reciepe_app/core/error/failure.dart';
// import 'package:reciepe_app/models/category_model.dart';
// import 'package:reciepe_app/models/meal_detail_model.dart';
// import 'package:reciepe_app/models/meal_model.dart';

// class ApiService {
//   final dio = Dio(
//     BaseOptions(
//       // connectTimeout: ,
//       // receiveTimeout: Duration(milliseconds: 1),
//       baseUrl: "https://www.themealdb.com/api/json/v1/1",
//       headers: {
//         "Accept": "application/json",
//         "Content-Type": "application/json",
//       },
//     ),
//   );
//   ApiService() {
//     dio.interceptors.add(
//       PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         responseHeader: false,
//         error: true,
//         compact: true,
//         maxWidth: 90,
//         enabled: kDebugMode,
//         filter: (options, args) {
//           // don't print requests with uris containing '/posts'
//           if (options.path.contains('/posts')) {
//             return false;
//           }
//           // don't print responses with unit8 list data
//           return !args.isResponse || !args.hasUint8ListData;
//         },
//       ),
//     );
//   }

  // Future<Either<Failure, List<CategoryModel>>> getCategories() async {
  //   try {
  //     final response = await dio.get("/categories.php");
  //     if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //       final jsonRes = response.data["categories"] as List;
  //       final modelRes = jsonRes
  //           .map(((e) => CategoryModel.fromJson(e)))
  //           .toList();
  //       return right(modelRes);
  //     } else {
  //       throw Exception("Something went wrong");
  //     }
  //   } on DioException catch (e) {
  //     final failure = HandleError.handle(e);
  //     return left(failure);
  //   }
  // }

  // Future<Either<Failure, List<MealModel>>> getMealsByCategory(
  //   String category,
  // ) async {
  //   try {
  //     final response = await dio.get(
  //       "/filter.php",
  //       queryParameters: {"c": category},
  //     );
  //     if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //       if (response.data["meals"] == null) {
  //         return right([]);
  //       }
  //       final jsonRes = response.data["meals"] as List;
  //       final modelRes = jsonRes.map(((e) => MealModel.fromJson(e))).toList();
  //       return right(modelRes);
  //     } else {
  //       throw Exception("Something went wrong");
  //     }
  //   } on DioException catch (e) {
  //     final failure = HandleError.handle(e);
  //     return left(failure);
  //   }
  // }

//   Future<Either<Failure, MealDetailModel>> getMealDetails(String mealId) async {
//     try {
//       final response = await dio.get(
//         "/lookup.php",
//         queryParameters: {"i": mealId},
//       );
//       if (response.statusCode! >= 200 && response.statusCode! < 300) {
//         final jsonRes = response.data["meals"] as List;
//         if (jsonRes.isNotEmpty) {
//           return right(MealDetailModel.fromJson(jsonRes.first));
//         } else {
//           throw Exception("Meal details not found");
//         }
//       } else {
//         throw Exception("Something went wrong");
//       }
//     } on DioException catch (e) {
//       final failure = HandleError.handle(e);
//       return left(failure);
//     }
//   }
// }
