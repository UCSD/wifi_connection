import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wifi_connection/WifiConnection.dart';

void main() {
  const MethodChannel channel = MethodChannel('WifiConnection');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      print('Mock method called: ${methodCall.method}');
      print('Mock method arguments: ${methodCall.arguments}');
      print('Mock returning: "42"');
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getWifiInfo', () async {
    print('Starting getWifiInfo test...');
    final result = await WifiConnection.wifiInfo;
    print('WifiConnection.wifiInfo returned: $result');
    expect(result, '42');
  });
}
