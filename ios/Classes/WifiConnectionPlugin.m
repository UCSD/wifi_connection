#import "WifiConnectionPlugin.h"
#if __has_include(<wifi_connection/wifi_connection-Swift.h>)
#import <wifi_connection/wifi_connection-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wifi_connection-Swift.h"
#endif

@implementation WifiConnectionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWifiConnectionPlugin registerWithRegistrar:registrar];
}
@end
