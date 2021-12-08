import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_weather_state.dart';

class DetailWeatherCubit extends Cubit<DetailWeatherState> {
  DetailWeatherCubit() : super(DetailWeatherState());

  void changeIndex(int index) {
    if (index == state.indexSelected && state.checkSelected == true) {
      emit(
        state.copyWith(
          checkSelected: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        indexSelected: index,
        checkSelected: true,
      ),
    );
  }
}
