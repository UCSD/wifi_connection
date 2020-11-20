import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wifi_connection/WifiConnection.dart';

void main() {
  const MethodChannel channel = MethodChannel('WifiConnection');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getWifiInfo', () async {
    expect(await WifiConnection.wifiInfo, '42');
  });
}
