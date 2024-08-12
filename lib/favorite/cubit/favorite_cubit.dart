import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radio_station/core/shared_prefs_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(String uuid)
      : _sharedPreferencesService = SharedPreferencesService(),
        super(const FavoriteState()) {
    checkState(uuid);
  }

  final SharedPreferencesService _sharedPreferencesService;

  Future<void> checkState(String uuid) async {
    List<String> favoriteStations = _sharedPreferencesService.getStringList('favoriteStations') ?? [];

    emit(state.copyWith(isFavorite: favoriteStations.contains(uuid)));
  }

  Future<void> markAsFavorite(String uuid) async {
    // Retrieve the current list of favorites
    List<String> favoriteStations = _sharedPreferencesService.getStringList('favoriteStations') ?? [];

    // Check if the UUID exists in the list
    if (favoriteStations.contains(uuid)) {
      // If it exists, remove it
      favoriteStations.remove(uuid);
      emit(state.copyWith(isFavorite: false));
    } else {
      // If it doesn't exist, add it
      favoriteStations.add(uuid);
      emit(state.copyWith(isFavorite: true));
    }

    // Save the updated list back to SharedPreferences
    await _sharedPreferencesService.setStringList('favoriteStations', favoriteStations);
  }
}
