import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Storage {
  String? get token;

  String? get dogs;

  ThemeMode get themeMode;

  Future<bool> saveToken({required String token});

  Future<void> clearToken();

  Future<bool> saveDogs({required String json});

  Future<void> saveThemeMode(ThemeMode themeMode);
}

class StorageImpl implements Storage {
  StorageImpl({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const _token = 'token';
  static const _dogs = 'dogs';
  static const _themeMode = 'themeMode';

  @override
  String? get token => _sharedPreferences.getString(_token);

  @override
  String? get dogs => _sharedPreferences.getString(_dogs);

  @override
  ThemeMode get themeMode {
    String value = _sharedPreferences.getString(_themeMode) ?? 'system';

    return ThemeMode.values.firstWhere((e) => e.name == value);
  }

  @override
  Future<bool> saveToken({required String token}) => _sharedPreferences.setString(_token, token);

  @override
  Future<void> clearToken() => _sharedPreferences.remove(_token);

  @override
  Future<bool> saveDogs({required String json}) => _sharedPreferences.setString(_dogs, json);

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) => _sharedPreferences.setString(_themeMode, themeMode.name);
}
