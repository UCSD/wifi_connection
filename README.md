
# WifiConnection

Flutter plugin to get Wifi Connection Info

Info | Android | iOS
-|-|-
ssid|:heavy_check_mark:|:heavy_check_mark:
bssid|:heavy_check_mark:|:heavy_check_mark:
ipAddress|:heavy_check_mark:|:x:
macAddress|:heavy_check_mark:|:heavy_check_mark:
linkSpeed|:heavy_check_mark:|:x:
signalStrength|:heavy_check_mark:|:x:
frequency|:heavy_check_mark:|:x:
networkId|:heavy_check_mark:|:x:
isHiddenSSID|:heavy_check_mark:|:x:
routerIp|:heavy_check_mark:|:heavy_check_mark:
channel|:heavy_check_mark:|:x:

## Usage
```dart
import 'package:WifiConnection/WifiConnection.dart';  
import 'package:WifiConnection/WifiInfo.dart';

WifiInfo _wifiInfo = WifiInfo();
_wifiInfo = await WifiConnection.wifiInfo;

print(_wifiInfo.ssid);
...
```
