
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_counter/core/locator/locator.config.dart';


final locator = GetIt.instance;

@InjectableInit(asExtension: false, initializerName: 'initGetIt')
Future setupLocator() async {
  initGetIt(locator);
}
