import UIKit
import Flutter
import CoreLocation
import SystemConfiguration.CaptiveNetwork

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let wifiChannel = FlutterMethodChannel(name: "WifiConnection",
                                              binaryMessenger: controller.binaryMessenger)
    wifiChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          guard call.method == "getWifiInfo" else {
            result(FlutterMethodNotImplemented)
            return
          }
          self.getWifiInfo(result: result)
 
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    private func getWifiInfo(result: FlutterResult){
        var map: Dictionary<String, String> = [:]
        let interfaces = CNCopySupportedInterfaces() as! [String]
        for interface in interfaces{
            if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? {
                         let ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                let bssid = interfaceInfo[kCNNetworkInfoKeyBSSID as String]
            
                map["SSID"] = ssid!
                map["BSSID"] = bssid! as? String
                map["IP"] = getAddress(for: Network.wifi)!
                map["MACADDRESS"] = UIDevice().identifierForVendor?.uuidString ?? ""
                map["LINKSPEED"] = ""
                map["SIGNALSTRENGTH"] = ""
                map["FREQUENCY"] = ""
                map["NETWORKID"] = ""
                map["ISHIDDEDSSID"] = ""
                map["ROUTERIP"] = ""
                map["CHANNEL"] = ""
                result(map)
                break
                      }

        }
        
    }
    
    
    
    enum Network: String {
        case wifi = "en0"
        case cellular = "pdp_ip0"
        case ipv4 = "ipv4"
        case ipv6 = "ipv6"
    }
    func getAddress(for network: Network) -> String? {
        var address: String?

        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if name == network.rawValue {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)

        return address
    }
    
    let locationManager = CLLocationManager()
    var networkType: String

    init(networkType: String){
        self.networkType = networkType
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.pausesLocationUpdatesAutomatically = false
    }
}
