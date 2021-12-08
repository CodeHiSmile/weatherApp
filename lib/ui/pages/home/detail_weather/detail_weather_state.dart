part of 'detail_weather_cubit.dart';

class DetailWeatherState extends Equatable {
  final bool? checkSelected;
  final int? indexSelected;

  DetailWeatherState({
    this.checkSelected = false,
    this.indexSelected = 0,
  });

  DetailWeatherState copyWith({
    bool? checkSelected,
    int? indexSelected,
  }) {
    return DetailWeatherState(
      indexSelected: indexSelected ?? this.indexSelected,
      checkSelected: checkSelected ?? this.checkSelected,
    );
  }

  @override
  List<Object?> get props => [
        checkSelected,
        indexSelected,
      ];
}
