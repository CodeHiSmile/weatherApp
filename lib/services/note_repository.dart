import 'package:injectable/injectable.dart';

abstract class INoteRepository {
}

@LazySingleton(as: INoteRepository)
class NoteRepository extends INoteRepository {
}
