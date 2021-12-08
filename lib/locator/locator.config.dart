// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../blocs/app_cubit.dart' as _i3;
import '../network/api_client.dart' as _i7;
import '../services/weather_repository.dart' as _i6;
import '../ui/pages/home/home_cubit.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.factory<_i3.AppCubit>(() => _i3.AppCubit());
  gh.lazySingleton<_i4.Dio>(() => injectableModule.dio);
  gh.factory<_i5.HomeCubit>(
      () => _i5.HomeCubit(repository: get<_i6.IWeatherRepository>()));
  gh.lazySingleton<_i6.IWeatherRepository>(
      () => _i6.WeatherRepository(get<_i7.ApiClient>()));
  return get;
}

class _$InjectableModule extends _i6.InjectableModule {}
