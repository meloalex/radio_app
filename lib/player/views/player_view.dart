import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_station/core/loader.dart';
import 'package:radio_station/core/radio_station.dart';
import 'package:radio_station/player/cubit/player_cubit.dart';
import 'package:radio_station/player/widgets/error.dart';
import 'package:radio_station/player/widgets/player.dart';
import 'package:rive/rive.dart';

class PlayerView extends StatefulWidget {
  final RadioStation radioStation;

  const PlayerView({super.key, required this.radioStation});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  SMIBool? _play;
  late RiveAnimationController _controller;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _play = controller.findInput<bool>('Play') as SMIBool;
    _play?.change(true);
  }

  @override
  void initState() {
    super.initState();

    _controller = SimpleAnimation('Timeline 1');

    BlocProvider.of<PlayerCubit>(context).play(widget.radioStation.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
            size: 32,
          ),
        ),
        title: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.radioStation.country,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: BlocConsumer<PlayerCubit, PlayerState>(
        listener: (context, state) {
          if (state is PlayerPlaying) {
            _play?.change(true);
            _controller.isActive = true;
          }

          if (state is PlayerPaused) {
            _play?.change(false);
            _controller.isActive = false;
          }
        },
        builder: (context, state) {
          if (state is PlayerLoading) {
            return const GenericLoader();
          }

          if (state is PlayerPlaying || state is PlayerPaused) {
            return Player(
              radioStation: widget.radioStation,
              onRiveInit: _onRiveInit,
              controller: _controller,
            );
          }

          if (state is PlayerError) {
            return const RadioPlayerError();
          }

          return const Center(
            child: Text("Something went wrong, please try again later."),
          );
        },
      ),
    );
  }
}
