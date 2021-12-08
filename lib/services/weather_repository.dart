import 'package:demo/configs/app_config.dart';
import 'package:demo/models/entities/info_weather_entity.dart';
import 'package:demo/models/entities/weather_by_day_entity.dart';
import 'package:demo/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class IWeatherRepository {
  Future<InfoWeatherEntity> getWeatherByCityName({
    String? address,
    String? units,
    String? appId,
  });

  Future<WeatherByDayEntity> getWeatherByHour({
    String? lat,
    String? lon,
    String? exclude,
    String? units,
    String? appId,
  });
}

@module
abstract class InjectableModule {
  @lazySingleton
  Dio get dio => Dio();
}

@LazySingleton(as: IWeatherRepository)
class WeatherRepository extends IWeatherRepository {
  @module
  ApiClient apiClient;

  WeatherRepository(this.apiClient);

  @override
  Future<InfoWeatherEntity> getWeatherByCityName({
    String? address,
    String? units,
    String? appId,
  }) async {
    return await apiClient.getWeatherByCityName(
      address: address,
      units: 'metric',
      appId: AppConfig.apiKey,
    );
  }

  @override
  Future<WeatherByDayEntity> getWeatherByHour({
    String? lat,
    String? lon,
    String? exclude,
    String? units,
    String? appId,
  }) async {
    return await apiClient.getWeatherByHour(
      lat: lat,
      lon: lon,
      exclude: exclude,
      units: 'metric',
      appId: AppConfig.apiKey,
    );
  }
}
