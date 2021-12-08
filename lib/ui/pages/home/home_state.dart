part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus? loadStatus;
  final InfoWeatherEntity? weatherCurrent;
  final WeatherByDayEntity? weatherByDay;
  final int? indexSelected;

  HomeState({
    this.loadStatus,
    this.weatherByDay,
    this.weatherCurrent,
    this.indexSelected = 0,
  });

  HomeState copyWith({
    LoadStatus? loadStatus,
    InfoWeatherEntity? weatherCurrent,
    WeatherByDayEntity? weatherByDay,
    int? indexSelected,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      weatherCurrent: weatherCurrent ?? this.weatherCurrent,
      weatherByDay: weatherByDay ?? this.weatherByDay,
      indexSelected: indexSelected ?? this.indexSelected,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        weatherByDay,
        weatherCurrent,
        indexSelected,
      ];
}
