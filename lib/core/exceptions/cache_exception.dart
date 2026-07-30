import 'package:dio/dio.dart';

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class ServerException implements Exception {
  final DioException error;
  ServerException(this.error);
}
