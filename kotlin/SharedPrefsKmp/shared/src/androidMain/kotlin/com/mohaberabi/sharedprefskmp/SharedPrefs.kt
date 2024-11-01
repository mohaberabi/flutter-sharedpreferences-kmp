package com.mohaberabi.sharedprefskmp

import android.content.Context

actual class SharedPrefs(
    private val context: Context
) {


    private val prefs by lazy {
        context.applicationContext.getSharedPreferences("kmpPrefs", Context.MODE_PRIVATE)
    }

    actual fun getString(key: String): String? = prefs.getString(key, null)

    actual fun setString(
        key: String,
        value: String
    ) = prefs.edit().putString(key, value).apply()

    actual fun getInt(key: String, default: Int): Int? = prefs.getInt(key, default)
    actual fun setInt(key: String, value: Int) = prefs.edit().putInt(key, value).apply()
    actual fun getBoolean(key: String, default: Boolean): Boolean? = prefs.getBoolean(key, default)
    actual fun setBoolean(key: String, value: Boolean) = prefs.edit().putBoolean(key, value).apply()


    actual fun remove(key: String) = prefs.edit().remove(key).apply()

    actual fun clear() = prefs.edit().clear().apply()
    actual fun getDouble(key: String, default: Double): Double {
        val value = prefs.getString(key, null)
        return value?.toDoubleOrNull() ?: default
    }

    actual fun setDouble(key: String, value: Double) {
        prefs.edit().putString(key, value.toString()).apply()
    }

    actual fun getStringList(key: String): List<String>? {
        val stringSet = prefs.getStringSet(key, null)
        return stringSet?.toList()
    }

    actual fun setStringList(
        key: String,
        values: List<String>
    ) {
        prefs.edit().putStringSet(key, values.toSet()).apply()
    }

    actual fun contains(key: String): Boolean = prefs.contains(key)
}