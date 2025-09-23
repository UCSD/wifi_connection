import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wifi_connection/WifiConnection.dart';

void main() {
  const MethodChannel channel = MethodChannel('WifiConnection');

  TestWidgetsFlutterBinding.ensureInitialized();

  // setUp(() {
  //   channel.setMockMethodCallHandler((MethodCall methodCall) async {
  //     return '42';
  //   });
  // });

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return <String, dynamic>{'LINKSPEED': '42'};
      },
    );
  });

  // tearDown(() {
  //   channel.setMockMethodCallHandler(null);
  // });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getWifiInfo', () async {
    final wifiInfo = await WifiConnection.wifiInfo;
    expect(wifiInfo.linkSpeed, '42');
  });
}
