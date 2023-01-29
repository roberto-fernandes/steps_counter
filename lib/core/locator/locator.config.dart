// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:steps_counter/core/utils/notification_helper.dart' as _i4;
import 'package:steps_counter/step_counter/data/data_source/health/health_mock_data_source.dart'
    as _i3;
import 'package:steps_counter/step_counter/data/data_source/settings/settings_local_data_source.dart'
    as _i5;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.HealthMockDataSource>(() => _i3.HealthMockDataSource());
  gh.lazySingleton<_i4.NotificationsHelper>(() => _i4.NotificationsHelper());
  gh.lazySingleton<_i5.SettingsLocalDataSource>(
      () => _i5.SettingsLocalDataSource());
  return getIt;
}
