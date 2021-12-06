import 'package:injectable/injectable.dart';

abstract class IWeatherRepository {
}

@LazySingleton(as: IWeatherRepository)
class NoteRepository extends IWeatherRepository {
}
