part of 'player_cubit.dart';

sealed class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class PlayerLoading extends PlayerState {
  const PlayerLoading();

  @override
  String toString() => "PlayerLoading { }";
}

class PlayerPlaying extends PlayerState {
  const PlayerPlaying();

  @override
  String toString() => "PlayerPlaying { }";
}

class PlayerPaused extends PlayerState {
  const PlayerPaused();

  @override
  String toString() => "PlayerPaused { }";
}

class PlayerError extends PlayerState {
  final String error;

  const PlayerError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => "PlayerError { error: $error }";
}
