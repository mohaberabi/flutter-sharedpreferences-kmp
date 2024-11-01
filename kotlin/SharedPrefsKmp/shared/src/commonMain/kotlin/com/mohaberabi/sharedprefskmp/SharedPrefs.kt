package com.mohaberabi.sharedprefskmp

expect class SharedPrefs {
    fun getString(key: String): String?
    fun setString(key: String, value: String)
    fun getInt(key: String, default: Int): Int?
    fun setInt(key: String, value: Int)
    fun getBoolean(key: String, default: Boolean): Boolean?
    fun setBoolean(key: String, value: Boolean)
    fun remove(key: String)
    fun clear()
    fun getDouble(key: String, default: Double): Double

    fun setDouble(key: String, value: Double)

    fun getStringList(key: String): List<String>?
    fun setStringList(key: String, values: List<String>)
    fun contains(key: String): Boolean
}