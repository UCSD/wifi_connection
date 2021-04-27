class WifiInfo {
  String? _bssid = "missing";
  String? _ssid = "missing";
  String? _ip = "missing";
  String? _macAddress = "missing";
  String? _linkSpeed = "";
  String? _singalStrength = "";
  String? _frequency = "";
  String? _channel = "";
  String? _networkid = "";
  String? _isHiddenSSID = "false";
  String? _routerIp = "unknown";

  WifiInfo();

  /*
   * Associate variables w/ naming in map from native platforms.
   * Parameter passed in by native platforms
   */
  WifiInfo.withMap(Map<dynamic, dynamic>? nativeInfo) {
    if (nativeInfo != null) {
      this._bssid = nativeInfo["BSSID"];
      this._ssid = nativeInfo["SSID"];
      this._ip = nativeInfo["IP"];
      this._macAddress = nativeInfo["MACADDRESS"];
      this._linkSpeed = nativeInfo["LINKSPEED"];
      this._singalStrength = nativeInfo["SIGNALSTRENGTH"];
      this._frequency = nativeInfo["FREQUENCY"];
      this._channel = nativeInfo["CHANNEL"];
      this._networkid = nativeInfo["NETWORKID"];
      this._isHiddenSSID = nativeInfo["ISHIDDENSSID"];
      this._routerIp = nativeInfo["ROUTERIP"];
    }
  }

  /// iOS and Android
  /// IPV4 address for connected device
  String? get ipAddress {
    return this._ip;
  }

  /// Android only
  /// IPV4 address for router of the connected device
  String? get routerIp {
    return this._routerIp;
  }

  // iOS and Android
  String? get bssid {
    return this._bssid;
  }

  // iOS and Android
  /// Network name
  String? get ssid {
    return this._ssid;
  }

  // iOS and Android
  String? get macAddress {
    return this._macAddress;
  }

  /// Android only
  String? get linkSpeed {
    return this._linkSpeed;
  }

  /// Android only
  String? get signalStrength {
    return this._singalStrength;
  }

  /// Android only
  String? get frequency {
    return this._frequency;
  }

  /// Android only
  String? get channel {
    return this._channel;
  }

  /// Android only
  String? get networkId {
    return this._networkid;
  }

  /// iOS and Android
  String? get isHiddenSSID {
    return this._isHiddenSSID;
  }
}
