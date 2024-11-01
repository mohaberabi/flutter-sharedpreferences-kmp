import 'package:flutter/services.dart';

abstract interface class PrefsParams {
  static const String key = "key";
  static const String value = "value";
  static const String defaultt = "default";
  static const String values = "values";
}

abstract interface class PrefsConst {
  static const MethodChannel channel =
      MethodChannel('com.mohaberabi.fluttersharedprefs.kmp');
  static const String getString = "getString";
  static const String setString = "setString";
  static const String getInt = "getInt";
  static const String setInt = "setInt";
  static const String getBoolean = "getBoolean";
  static const String setBoolean = "setBoolean";
  static const String remove = "remove";
  static const String clear = "clear";
  static const String getStringList = "getStringList";
  static const String setStringList = "setStringList";
  static const String contains = "contains";
}
