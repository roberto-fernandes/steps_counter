import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steps_counter/core/data/base_repository.dart';
import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/step_counter/data/repository/health_repository.dart';
import 'package:steps_counter/step_counter/data/repository/settings_repository.dart';
import 'package:steps_counter/step_counter/presentation/page/step_counter_page.dart';
import 'package:steps_counter/step_counter/presentation/widget/notification_widget.dart';

void main() {
  group('StepCounterPage', () {
    testWidgets('displays a Scaffold with correct elements', (tester) async {
      await setupLocator();
      await tester.pumpWidget(
        MaterialApp(
          home: MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => HealthRepository(
                  defaultDataSourceType: DataSourceType.mock,
                ),
              ),
              RepositoryProvider(
                  create: (context) => SettingsRepository(
                        defaultDataSourceType: DataSourceType.mock,
                      )),
            ],
            child: const StepCounterView(),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(NotificationWidget), findsOneWidget);
      expect(find.byType(StepCounterContent), findsOneWidget);
    });
  });
}
