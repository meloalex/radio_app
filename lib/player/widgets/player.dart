import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio_station/core/radio_station.dart';
import 'package:radio_station/favorite/view/favorite_button.dart';
import 'package:radio_station/player/cubit/player_cubit.dart';

import 'package:radio_station/player/widgets/tag_list.dart';
import 'package:rive/rive.dart' as rive;

class Player extends StatefulWidget {
  final RadioStation radioStation;
  final Function(rive.Artboard) onRiveInit;
  final rive.RiveAnimationController controller;

  const Player({
    super.key,
    required this.radioStation,
    required this.onRiveInit,
    required this.controller,
  });

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Column(
              children: [
                // Station Image
                widget.radioStation.favicon != null && widget.radioStation.favicon!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          widget.radioStation.favicon!,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: const rive.RiveAnimation.asset(
                          "assets/animations/radio.riv",
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(height: 30),
                // Station Title and Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Station Name
                      Text(
                        widget.radioStation.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 24.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Favorite Button
                          FavoriteButton(
                            radioStation: widget.radioStation,
                          ),
                          // Share Button
                          IconButton(
                            icon: Icon(Icons.share, color: Theme.of(context).primaryColor, size: 28),
                            onPressed: () {
                              // Implement share functionality
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Tags
            if (widget.radioStation.tags?.isNotEmpty ?? false) TagsList(tags: widget.radioStation.tags!.split(',')),
            const SizedBox(height: 30),
            // Play/Pause Button
            PlayPauseButton(
              onRiveInit: widget.onRiveInit,
            ),
          ],
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key, required this.onRiveInit});

  final Function(rive.Artboard) onRiveInit;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 150,
        height: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => BlocProvider.of<PlayerCubit>(context).togglePlay(),
              child: rive.RiveAnimation.asset(
                "assets/animations/play_button_black.riv",
                onInit: onRiveInit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/* 
 SafeArea(
      child: Stack(
        children: [
          rive.RiveAnimation.asset(
            "assets/animations/radio.riv",
            controllers: [widget.controller],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _togglePlay,
                    child: rive.RiveAnimation.asset(
                      "assets/animations/play_button_black.riv",
                      onInit: widget.onRiveInit,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.radioStation.favicon != null && widget.radioStation.favicon!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            widget.radioStation.favicon!,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 200.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.grey.withOpacity(0.3), // Placeholder color if image is null
                          ),
                        ),
                  Text(
                    widget.radioStation.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.radioStation.country,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '${widget.radioStation.tags}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const PlayerBackButton(),
        ],
      ),
    )*/