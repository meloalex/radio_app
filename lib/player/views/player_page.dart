import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_station/core/radio_station.dart';
import 'package:radio_station/player/cubit/player_cubit.dart';
import 'package:radio_station/player/views/player_view.dart';

class PlayerPage extends StatelessWidget {
  final RadioStation radioStation;

  const PlayerPage({super.key, required this.radioStation});

  static Route<void> route(RadioStation radioStation) {
    return MaterialPageRoute<void>(builder: (_) => PlayerPage(radioStation: radioStation));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerCubit>(
      create: (context) => PlayerCubit(),
      child: PlayerView(radioStation: radioStation),
    );
  }
}
