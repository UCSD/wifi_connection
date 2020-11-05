package edu.ucsd.WifiConnection

import android.content.Context
import android.net.wifi.WifiManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** WifiConnectionPlugin */
class WifiConnectionPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context : Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "WifiConnection")
    context = flutterPluginBinding.applicationContext
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getWifiInfo" -> {
        result.success(getWifiInfo())
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun getWifiInfo(): MutableMap<String, Any> {
    val data: MutableMap<String, Any> = HashMap()
    var wifiManager = context.getSystemService(Context.WIFI_SERVICE) as WifiManager
    var wifiInfo = wifiManager.connectionInfo

      data["SSID"] = wifiInfo.ssid
      data["BSSID"] = wifiInfo.bssid
      data["IP"] = wifiInfo.ipAddress
      data["MACADDRESS"] = wifiInfo.macAddress
      data["LINKSPEED"] = wifiInfo.linkSpeed
      data["SIGNALSTRENGTH"] = wifiInfo.rssi
      //data["FREQUENCY"] = wifiInfo.frequency
      data["NETWORKID"] = wifiInfo.networkId
      //data["CONNECTIONTYPE"] = wifiInfo.
      data["ISHIDDEDSSID"] = wifiInfo.hiddenSSID
      //data["ROUTERIP"] = wifiInfo.
    return data
  }
}
