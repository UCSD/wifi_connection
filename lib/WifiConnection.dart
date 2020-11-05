
import 'dart:async';

import 'package:flutter/services.dart';

import 'WifiInfo.dart';

class WifiConnection {
  static const MethodChannel _channel =
      const MethodChannel('WifiConnection');

  static Future<WifiInfo> get wifiInfo async {
    final Map<dynamic, dynamic> data = await _channel.invokeMethod('getWifiInfo');
    WifiInfo wifiInfo = new WifiInfo.withMap(data);
    return wifiInfo;
  }
}
