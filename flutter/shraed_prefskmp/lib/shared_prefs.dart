import 'package:shraed_prefskmp/shared_prefs_params.dart';

class SharedPrefs {
  Future<String?> getString(String key) async {
    final String? value = await PrefsConst.channel.invokeMethod(
      PrefsConst.getString,
      {PrefsParams.key: key},
    );
    return value;
  }

  Future<void> setString(String key, String value) async {
    await PrefsConst.channel.invokeMethod(
      PrefsConst.setString,
      {PrefsParams.key: key, PrefsParams.value: value},
    );
  }

  Future<int?> getInt(String key, {int defaultValue = 0}) async {
    final int? value = await PrefsConst.channel.invokeMethod(
      PrefsConst.getInt,
      {PrefsParams.key: key, PrefsParams.defaultt: defaultValue},
    );
    return value;
  }

  Future<void> setInt(String key, int value) async {
    await PrefsConst.channel.invokeMethod(
      PrefsConst.setInt,
      {PrefsParams.key: key, PrefsParams.value: value},
    );
  }

  Future<bool?> getBoolean(String key, {bool defaultValue = false}) async {
    final value = await PrefsConst.channel.invokeMethod(
      PrefsConst.getBoolean,
      {PrefsParams.key: key, PrefsParams.defaultt: defaultValue},
    );
    if (value == null) {
      return null;
    } else {
      if (value is bool) {
        return value;
      } else if (value is int) {
        if (value == 0) {
          return false;
        } else {
          return true;
        }
      }
    }
    return value;
  }

  Future<void> setBoolean(String key, bool value) async {
    await PrefsConst.channel.invokeMethod(
      PrefsConst.setBoolean,
      {PrefsParams.key: key, PrefsParams.value: value},
    );
  }

  Future<void> remove(String key) async {
    await PrefsConst.channel.invokeMethod(
      PrefsConst.remove,
      {PrefsParams.key: key},
    );
  }

  Future<void> clear() async {
    await PrefsConst.channel.invokeMethod(PrefsConst.clear);
  }

  Future<List<String>?> getStringList(String key) async {
    final List<Object?>? value = await PrefsConst.channel.invokeMethod(
      PrefsConst.getStringList,
      {PrefsParams.key: key},
    );
    return value?.cast<String>();
  }

  Future<void> setStringList(String key, List<String> values) async {
    await PrefsConst.channel.invokeMethod(
      PrefsConst.setStringList,
      {PrefsParams.key: key, PrefsParams.values: values},
    );
  }

  Future<bool> contains(String key) async {
    final bool exists = await PrefsConst.channel.invokeMethod(
      PrefsConst.contains,
      {PrefsParams.key: key},
    );
    return exists;
  }
}
