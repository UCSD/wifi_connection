// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:wifi_connection_example/main.dart';

void main() {
  testWidgets('Verify WiFi info is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that WiFi information fields are displayed with default values.
    expect(find.text('SSID: missing\n'), findsOneWidget);
    expect(find.text('BSSID: missing\n'), findsOneWidget);
    expect(find.text('IP: missing\n'), findsOneWidget);
    expect(find.text('MAC Address: missing\n'), findsOneWidget);

    // Verify additional WiFi fields are present
    expect(find.textContaining('Link Speed:'), findsOneWidget);
    expect(find.textContaining('Signal Strength:'), findsOneWidget);
    expect(find.textContaining('Router IP:'), findsOneWidget);

    // Verify the refresh button is present and functional
    expect(find.text('Refresh'), findsOneWidget);

    // Verify the app title
    expect(find.text('Plugin example app'), findsOneWidget);

    // Test refresh button tap
    await tester.tap(find.text('Refresh'));
    await tester.pump();

    // Verify the app still shows the WiFi info after refresh
    expect(find.text('SSID: missing\n'), findsOneWidget);
  });
}
