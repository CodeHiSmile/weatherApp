import 'package:demo/locator/locator.config.dart';
import 'package:demo/network/api_client.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configurationInjection() {
  $initGetIt(getIt);
}
