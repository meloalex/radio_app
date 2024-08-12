import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:radio_station/core/radio_station.dart';

// http://91.132.145.114/json/stations?limit=500
// http://91.132.145.114/json/stations/bycountrycodeexact/es?limit=100

class RadioStationRepository {
  final String _baseUrl = "http://91.132.145.114/json/stations?limit=100";

  Future<List<RadioStation>> fetchStations() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode != 200 || response.body.isEmpty) return [];

      final Iterable decodeJson = jsonDecode(response.body);
      final List<RadioStation> radioStations = decodeJson.map((item) => RadioStation.fromJson(item)).toList();

      return radioStations.where((station) => station.favicon != null).toList();
    } catch (err) {
      throw "Error while fetching radio stations from server. Error: $err";
    }
  }
}
