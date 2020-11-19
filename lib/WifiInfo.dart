class WifiInfo {
  String _bssid = "missing";
  String _ssid = "missing";
  String _ip = "missing";
  String _macAddress = "missing";
  String _linkSpeed = "";
  String _singalStrength = "";
  String _frequency ="";
  String _channel = "";
  String _networkid = "";
  String _isHiddenSSID = "false";
  String _routerIp = "unknown";

  WifiInfo();

  WifiInfo.withMap(Map<dynamic, dynamic> nativeInfo) {
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
      this._isHiddenSSID = nativeInfo["ISHIDDEDSSID"];
      this._routerIp = nativeInfo["ROUTERIP"];
    }
  }

  /// IPV4 address for connected device
  String get ipAddress {
    return this._ip;
  }

  /// IPV4 address for router of the connected device
  String get routerIp {
    return this._routerIp;
  }

  String get bssId {
    return this._bssid;
  }

  String get ssid {
    return this._ssid;
  }

  String get macAddress {
    return this._macAddress;
  }

  String get linkSpeed {
    return this._linkSpeed;
  }

  String get signalStrength {
    return this._singalStrength;
  }

  String get frequency {
    return this._frequency;
  }

  String get channel {
    return this._channel;
  }

  String get networkId {
    return this._networkid;
  }

  String get isHiddenSSid {
    return this._isHiddenSSID;
  }
}
