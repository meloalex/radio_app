import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_station/core/bloc_observer.dart';
import 'package:radio_station/core/shared_prefs_service.dart';
import 'package:radio_station/home/views/home_page.dart';
import 'package:radio_station/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  final sharedPreferencesService = SharedPreferencesService();
  await sharedPreferencesService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio Station App',
      theme: theme,
      home: const HomePage(),
    );
  }
}
