import 'package:demo/configs/app_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_client.dart';
import 'api_interceptors.dart';

@singleton
class ManagerApi {
  late final Dio dio;
  late final ApiClient apiClient;

  static final ManagerApi instance = ManagerApi._privateConstructor();

  ManagerApi._privateConstructor() {
    dio = Dio();
    dio.options.baseUrl = AppConfig.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.options.connectTimeout = const Duration(minutes: 3).inMilliseconds;
    dio.options.receiveTimeout = const Duration(minutes: 3).inMilliseconds;
    apiClient = ApiClient(dio, baseUrl: AppConfig.baseUrl);
  }
}