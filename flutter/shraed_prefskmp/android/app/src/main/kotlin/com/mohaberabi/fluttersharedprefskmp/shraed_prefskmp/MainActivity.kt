package com.mohaberabi.fluttersharedprefskmp.shraed_prefskmp

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.mohaberabi.sharedprefskmp.SharedPrefs

class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL_NAME = "com.mohaberabi.fluttersharedprefs.kmp"
        private const val GET_STRING = "getString"
        private const val SET_STRING = "setString"
        private const val GET_INT = "getInt"
        private const val SET_INT = "setInt"
        private const val GET_BOOLEAN = "getBoolean"
        private const val SET_BOOLEAN = "setBoolean"
        private const val REMOVE = "remove"
        private const val CLEAR = "clear"
        private const val GET_STRING_LIST = "getStringList"
        private const val SET_STRING_LIST = "setStringList"
        private const val CONTAINS = "contains"
    }

    private lateinit var sharedPrefs: SharedPrefs

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        sharedPrefs = SharedPrefs(applicationContext)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                GET_STRING -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = sharedPrefs.getString(key)
                    result.success(value)
                }

                SET_STRING -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = call.argument<String>("value") ?: ""
                    sharedPrefs.setString(key, value)
                    result.success(null)
                }

                GET_INT -> {
                    val key = call.argument<String>("key") ?: ""
                    val default = call.argument<Int>("default") ?: 0
                    val value = sharedPrefs.getInt(key, default)
                    result.success(value)
                }

                SET_INT -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = call.argument<Int>("value") ?: 0
                    sharedPrefs.setInt(key, value)
                    result.success(null)
                }

                GET_BOOLEAN -> {
                    val key = call.argument<String>("key") ?: ""
                    val default = call.argument<Boolean>("default") ?: false
                    val value = sharedPrefs.getBoolean(key, default)
                    result.success(value)
                }

                SET_BOOLEAN -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = call.argument<Boolean>("value") ?: false
                    sharedPrefs.setBoolean(key, value)
                    result.success(null)
                }

                REMOVE -> {
                    val key = call.argument<String>("key") ?: ""
                    sharedPrefs.remove(key)
                    result.success(null)
                }

                CLEAR -> {
                    sharedPrefs.clear()
                    result.success(null)
                }

                GET_STRING_LIST -> {
                    val key = call.argument<String>("key") ?: ""
                    val value = sharedPrefs.getStringList(key)
                    result.success(value)
                }

                SET_STRING_LIST -> {
                    val key = call.argument<String>("key") ?: ""
                    val values = call.argument<List<String>>("values") ?: emptyList()
                    sharedPrefs.setStringList(key, values)
                    result.success(null)
                }

                CONTAINS -> {
                    val key = call.argument<String>("key") ?: ""
                    val exists = sharedPrefs.contains(key)
                    result.success(exists)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
