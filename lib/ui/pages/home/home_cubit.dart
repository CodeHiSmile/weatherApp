import 'package:bloc/bloc.dart';
import 'package:demo/models/entities/info_weather_entity.dart';
import 'package:demo/models/entities/weather_by_day_entity.dart';
import 'package:demo/models/enums/load_status.dart';
import 'package:demo/services/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  IWeatherRepository? repository;

  HomeCubit({this.repository}) : super(HomeState(loadStatus: LoadStatus.initial));

  void getWeather({String address = 'Hanoi'}) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final weatherCurrent = await repository?.getWeatherByCityName(
        address: address,
      );

      final weatherByDay = await repository?.getWeatherByHour(
        lat: "${weatherCurrent?.coord?.lat ?? 0}",
        lon: "${weatherCurrent?.coord?.lon ?? 0}",
        exclude: 'daily',
      );

      emit(state.copyWith(
        loadStatus: LoadStatus.success,
        weatherCurrent: weatherCurrent,
        weatherByDay: weatherByDay,
      ));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void changeIndex(int index) => emit(state.copyWith(indexSelected: index));

  void showSearch(bool value) => emit(
        state.copyWith(showSearch: value),
      );
}
