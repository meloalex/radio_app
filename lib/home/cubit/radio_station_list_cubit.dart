import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radio_station/core/radio_repository.dart';
import 'package:radio_station/core/radio_station.dart';

part 'radio_station_list_state.dart';

class RadioStationListCubit extends Cubit<RadioStationListState> {
  RadioStationListCubit()
      : _radioStationRepository = RadioStationRepository(),
        super(RadioStationListLoading());

  final RadioStationRepository _radioStationRepository;

  Map<String, List<RadioStation>> groupByCountry(List<RadioStation> stations) {
    return groupBy(stations, (RadioStation station) => station.country);
  }

  void fetchStations() async {
    emit(RadioStationListLoading());

    final List<RadioStation> radioStations = await _radioStationRepository.fetchStations();

    // Group the stations by country
    final groupedStations = groupByCountry(radioStations);

    emit(RadioStationListLoaded(stationsByCountry: groupedStations));
  }

  void selectCountry(String? selectedCountry) {
    if (state is RadioStationListLoaded) {
      RadioStationListLoaded current = state as RadioStationListLoaded;
      emit(RadioStationListLoaded(stationsByCountry: current.stationsByCountry, countrySelected: selectedCountry));
    }
  }
}
