package edu.ucsd.WifiConnection

import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.net.wifi.WifiManager
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


/** WifiConnectionPlugin */
class WifiConnectionPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.RequestPermissionsResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel : MethodChannel
    private lateinit var context : Context
    private var currentActivity: Activity? = null
    private var permissionGranted: Boolean = false
    private val myPermissionCode = 72

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

  private fun getWifiInfo(): MutableMap<String, Any> {
      val data: MutableMap<String, Any> = HashMap()
      val wifiManager = context.getSystemService(Context.WIFI_SERVICE) as WifiManager
      val wifiInfo = wifiManager.connectionInfo
      val dhcpInfo = wifiManager.dhcpInfo
      val routerIp: String = formatIP(dhcpInfo.gateway)

      if (ActivityCompat.checkSelfPermission(context, android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
          ActivityCompat.requestPermissions(currentActivity!!, arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION), myPermissionCode);
      }

      data["SSID"] = wifiInfo.ssid.toString()
      data["BSSID"] = wifiInfo.bssid.toString()
      data["IP"] = formatIP(wifiInfo.ipAddress)
      data["MACADDRESS"] = wifiInfo.macAddress.toString()
      data["LINKSPEED"] = wifiInfo.linkSpeed.toString()
      data["SIGNALSTRENGTH"] = wifiInfo.rssi.toString()
      data["FREQUENCY"] = wifiInfo.frequency.toString()
      data["NETWORKID"] = wifiInfo.networkId.toString()
      data["ISHIDDEDSSID"] = wifiInfo.hiddenSSID.toString()
      data["ROUTERIP"] = routerIp
      data["CHANNEL"] = convertFrequencyToChannel(wifiInfo.frequency).toString()
    return data
  }

    private fun formatIP(ip: Int): String {
      return String.format(
          "%d.%d.%d.%d",
          ip and 0xff,
          ip shr 8 and 0xff,
          ip shr 16 and 0xff,
          ip shr 24 and 0xff
      )
    }

    private fun convertFrequencyToChannel(freq: Int): Int {
        if (freq == 2484)
            return 14
        else if (freq < 2484)
            return (freq - 2407) / 5
        else if (freq in 4910..4980)
            return (freq - 4000) / 5
        else if (freq < 5945)
            return (freq - 5000) / 5
        else if (freq <= 45000) /* DMG band lower limit */
        /* see 802.11ax D4.1 27.3.22.2 */
            return (freq - 5940) / 5
        else if (freq in 58320..70200)
            return (freq - 56160) / 2160
        else
            return 0
    }

    override fun onDetachedFromActivity() {
        currentActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        currentActivity = binding.activity
        binding.addRequestPermissionsResultListener(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        currentActivity = binding.activity
        binding.addRequestPermissionsResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        currentActivity = null
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>?, grantResults: IntArray?): Boolean {
        when (requestCode) {
            myPermissionCode -> {
                if ( null != grantResults ) {
                    permissionGranted = grantResults.isNotEmpty() &&
                            grantResults.get(0) == PackageManager.PERMISSION_GRANTED
                }
                // only return true if handling the request code
                return true
            }
        }
        return false
    }
}
