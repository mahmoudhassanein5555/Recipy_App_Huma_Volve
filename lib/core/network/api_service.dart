import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://www.themealdb.com/api/json/v1/1",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  );

  ApiService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("=======================Request=====================");
          print(options.method);
          print(options.baseUrl);
          print(options.path);
          print(options.queryParameters);
          print(options.data);
          print("==================================================");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("=====================Response======================");
          print(response.statusCode);
          print(response.statusMessage);
          print(response.headers);
          print(response.requestOptions);
          print(response.isRedirect);
          print(response.redirects);
          print(response.data);
          print("==================================================");
          return handler.next(response);
        },
        onError: (error, handler) {
          print("=====================Error======================");
          print(error.response?.statusCode);
          print(error.response?.statusMessage);
          print(error.response?.headers);
          print(error.response?.requestOptions);
          print("==================================================");
          return handler.next(error);
        },
      ),
    );
  }
}
