// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class LocalStorageHelper {
  static final Storage _localStorage = window.localStorage;

  static void saveValue(String key, String value) {
    _localStorage[key] = value;
  }

  static String getValue(String key) {
    return _localStorage[key] ?? '';
  }
}
