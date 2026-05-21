import 'local_preferences_stub.dart'
    if (dart.library.html) 'local_preferences_web.dart';

abstract final class LocalPreferences {
  static Future<String?> read(String key) => readPreference(key);

  static Future<void> write(String key, String value) =>
      writePreference(key, value);
}
