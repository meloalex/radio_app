import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_station/home/cubit/radio_station_list_cubit.dart';
import 'package:radio_station/home/views/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RadioStationListCubit>(
      create: (context) => RadioStationListCubit()..fetchStations(),
      child: const HomeView(),
    );
  }
}
