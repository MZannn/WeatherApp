import 'package:dio/dio.dart';
import 'package:weather_app/services/api_constant.dart';

class API {
  final Dio dio;
  static final API _api = API._internal(
    Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: const Duration(
          seconds: 15,
        ),
        receiveTimeout: const Duration(
          seconds: 15,
        ),
      ),
    ),
  );
  factory API() => _api;
  API._internal(this.dio);
}
