part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus? loadStatus;
  final InfoWeatherEntity? weatherCurrent;
  final WeatherByDayEntity? weatherByDay;
  final int? indexSelected;
  final bool showSearch;
  final String? addressSearch;

  HomeState({
    this.loadStatus,
    this.weatherByDay,
    this.weatherCurrent,
    this.indexSelected = 0,
    this.showSearch = false,
    this.addressSearch,
  });

  HomeState copyWith({
    LoadStatus? loadStatus,
    InfoWeatherEntity? weatherCurrent,
    WeatherByDayEntity? weatherByDay,
    int? indexSelected,
    bool? showSearch,
    String? addressSearch,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      weatherCurrent: weatherCurrent ?? this.weatherCurrent,
      weatherByDay: weatherByDay ?? this.weatherByDay,
      indexSelected: indexSelected ?? this.indexSelected,
      showSearch: showSearch ?? this.showSearch,
      addressSearch: addressSearch ?? this.addressSearch,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        weatherByDay,
        weatherCurrent,
        indexSelected,
        showSearch,
        addressSearch,
      ];
}
