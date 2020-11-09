class WifiInfo {
  String _bssid = "missing";
  String _ssid = "missing";
  String _ip = "missing";
  String _macAddress = "missing";
  int _linkSpeed = 0;
  int _singalStrength = 0;
  int _frequency = 0;
  int _channel = 0;
  int _networkid = 0;
  String _connectionType = "missing";
  bool _isHiddenSSID = false;
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
      this._connectionType = nativeInfo["CONNECTIONTYPE"];
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

  int get linkSpeed {
    return this._linkSpeed;
  }

  int get signalStrength {
    return this._singalStrength;
  }

  int get frequency {
    return this._frequency;
  }

  int get channel {
    return this._channel;
  }

  int get networkId {
    return this._networkid;
  }

  /// returns connection type eg wifi or mobile
  String get connectionType {
    return this._connectionType;
  }

  bool get isHiddenSSid {
    return this._isHiddenSSID;
  }
}
