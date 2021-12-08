import 'package:demo/network/api_client.dart';
import 'package:demo/network/manager_api.dart';
import 'package:demo/services/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ApiClient apiClient = ManagerApi.instance.apiClient;

  WeatherRepository repository = WeatherRepository(apiClient);

  test('Get Current Weather', () async {
    final weatherCurrent = await repository.getWeatherByCityName(
      address: "Hà Nội",
    );
    // ignore: unnecessary_null_comparison
    expect(weatherCurrent != null, equals(true));
  });

  test('Get Current Weather', () async {
    final weatherCurrent = await repository.getWeatherByCityName(
      address: "Hà Nội",
    );
    // ignore: unnecessary_null_comparison
    expect(weatherCurrent != null, equals(true));
  });
}
