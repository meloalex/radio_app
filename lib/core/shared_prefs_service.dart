import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  late SharedPreferences _prefs;

  // Private constructor
  SharedPreferencesService._internal();

  // Factory constructor to return the singleton instance
  factory SharedPreferencesService() {
    return _instance;
  }

  // Initialize SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a string value
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Get a string value
  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Save an int value
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  // Get an int value
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Save a bool value
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  // Get a bool value
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Save a double value
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  // Get a double value
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // Save a list of strings
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  // Get a list of strings
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // Check if a key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  // Remove a value
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Clear all values
  Future<void> clear() async {
    await _prefs.clear();
  }
}
