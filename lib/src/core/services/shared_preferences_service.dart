import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  // Inicializa a instância de SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Salvar um valor String
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Obter um valor String
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Salvar um valor Bool (ex: status de login)
  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Obter um valor Bool, com valor padrão se não existir
  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  // Remover um item
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }
}