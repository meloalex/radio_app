import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:radio_station/core/radio_station.dart';
import 'package:radio_station/home/widgets/radio_station_tile.dart';

class RadioStationList extends StatelessWidget {
  final List<RadioStation> radioStations;

  const RadioStationList({super.key, required this.radioStations});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: radioStations.length,
          itemBuilder: (context, index) => RadioStationTile(
            station: radioStations[index],
            index: index,
          ),
        ),
      ),
    );
  }
}
