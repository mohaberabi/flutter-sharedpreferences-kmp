package com.mohaberabi.sharedprefskmp


import platform.Foundation.NSUserDefaults

actual class SharedPrefs {


    companion object {
        private const val DOMAIN_NAME = "kmpPrefs"
    }

    private val prefs by lazy {
        NSUserDefaults.standardUserDefaults().apply {
            persistentDomainForName(DOMAIN_NAME)
        }
    }

    actual fun getString(key: String): String? = prefs.stringForKey(key)

    actual fun setString(key: String, value: String) {
        prefs.setObject(value, forKey = key)
        prefs.synchronize()
    }

    actual fun getInt(key: String, default: Int): Int? = prefs.integerForKey(key).toInt()

    actual fun setInt(key: String, value: Int) {
        prefs.setInteger(value.toLong(), forKey = key)
        prefs.synchronize()
    }

    actual fun getBoolean(key: String, default: Boolean): Boolean? {
        return try {
            prefs.boolForKey(key)
        } catch (e: Exception) {
            default
        }
    }

    actual fun setBoolean(key: String, value: Boolean) {
        prefs.setBool(value, forKey = key)
        prefs.synchronize()
    }

    actual fun remove(key: String) {
        prefs.removeObjectForKey(key)
        prefs.synchronize()
    }

    actual fun clear() {

        prefs.removePersistentDomainForName(DOMAIN_NAME)
        prefs.synchronize()
    }

    actual fun getDouble(key: String, default: Double): Double {

        return try {
            prefs.doubleForKey(key)
        } catch (e: Exception) {
            default
        }
    }

    actual fun setDouble(key: String, value: Double) {
        prefs.setDouble(value, forKey = key)
        prefs.synchronize()
    }

    actual fun getStringList(key: String): List<String>? {
        val array = prefs.arrayForKey(key) as? List<String>
        return array ?: emptyList()
    }

    actual fun setStringList(key: String, values: List<String>) {
        prefs.setObject(values, forKey = key)
        prefs.synchronize()
    }

    actual fun contains(key: String): Boolean = prefs.objectForKey(key) != null
}
