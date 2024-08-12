import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(const PlayerLoading());

  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;

  Future<void> play(String url) async {
    emit(const PlayerLoading());

    try {
      await assetsAudioPlayer.open(
        Audio.liveStream(url),
      );

      isPlaying = true;
      emit(const PlayerPlaying());
    } catch (e) {
      emit(PlayerError(error: e.toString()));
    }
  }

  Future<void> togglePlay() async {
    if (isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  Future<void> pause() async {
    assetsAudioPlayer.pause();
    isPlaying = false;
    return emit(const PlayerPaused());
  }

  Future<void> resume() async {
    assetsAudioPlayer.play();
    isPlaying = true;
    return emit(const PlayerPlaying());
  }

  @override
  Future<void> close() async {
    await assetsAudioPlayer.stop();
    await assetsAudioPlayer.dispose();
    return super.close();
  }
}
