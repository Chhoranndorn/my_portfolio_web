// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

Future<String?> readPreference(String key) async {
  return html.window.localStorage[key];
}

Future<void> writePreference(String key, String value) async {
  html.window.localStorage[key] = value;
}
