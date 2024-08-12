part of 'radio_station_list_cubit.dart';

sealed class RadioStationListState extends Equatable {
  const RadioStationListState();

  @override
  List<Object?> get props => [];
}

final class RadioStationListLoading extends RadioStationListState {}

final class RadioStationListLoaded extends RadioStationListState {
  final Map<String, List<RadioStation>> stationsByCountry;
  final String? countrySelected;

  const RadioStationListLoaded({required this.stationsByCountry, this.countrySelected});

  @override
  List<Object?> get props => [stationsByCountry, countrySelected];

  RadioStationListLoaded copyWith({
    Map<String, List<RadioStation>>? stationsByCountry,
    String? countrySelected,
  }) {
    return RadioStationListLoaded(
      stationsByCountry: stationsByCountry ?? this.stationsByCountry,
      countrySelected: countrySelected ?? this.countrySelected,
    );
  }

  @override
  String toString() => 'RadioStationListLoaded { countrySelected: $countrySelected, stations: ${stationsByCountry.length} }';
}

final class RadioStationListError extends RadioStationListState {
  final String error;

  const RadioStationListError({required this.error});

  @override
  List<Object> get props => [error];
}
