import 'package:flutter/material.dart';
import 'package:steps_counter/core/app_setup.dart';
import 'package:steps_counter/core/presentation/theme.dart';
import 'package:steps_counter/step_counter/presentation/page/step_counter_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSetup.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Step Counter',
      theme: defaultTheme,
      home: const StepCounterPage(),
    );
  }
}
