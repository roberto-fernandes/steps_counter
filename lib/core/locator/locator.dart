
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_counter/core/data/base_repository.dart';
import 'package:steps_counter/core/locator/locator.config.dart';
import 'package:steps_counter/step_counter/data/repository/health_repository.dart';
import 'package:steps_counter/step_counter/data/repository/settings_repository.dart';


final locator = GetIt.instance;

@InjectableInit(asExtension: false, initializerName: 'initGetIt')
Future setupLocator() async {
  locator.registerLazySingleton<HealthRepository>(() {
    return HealthRepository(defaultDataSourceType: DataSourceType.mock);
  });
  locator.registerLazySingleton<SettingsRepository>(() {
    return SettingsRepository(defaultDataSourceType: DataSourceType.local);
  });
  initGetIt(locator);
}
