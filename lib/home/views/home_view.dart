import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_station/core/loader.dart';
import 'package:radio_station/home/cubit/radio_station_list_cubit.dart';
import 'package:radio_station/home/widgets/app_bar.dart';
import 'package:radio_station/home/widgets/country_list.dart';
import 'package:radio_station/home/widgets/radio_station_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const HomeAppBar(),
      body: BlocBuilder<RadioStationListCubit, RadioStationListState>(
        builder: (context, state) {
          if (state is RadioStationListLoaded) {
            if (state.countrySelected != null && state.stationsByCountry[state.countrySelected] != null) {
              return RadioStationList(radioStations: state.stationsByCountry[state.countrySelected]!);
            } else {
              return CountryList(radioStations: state.stationsByCountry);
            }
          }

          if (state is RadioStationListLoading) {
            return const GenericLoader();
          }

          if (state is RadioStationListError) {
            return Center(
              child: Text(state.error),
            );
          }

          return Container();
        },
      ),
    );
  }
}
