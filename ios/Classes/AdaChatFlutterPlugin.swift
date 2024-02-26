import Flutter
import UIKit

public class AdaChatFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ada_chat_flutter", binaryMessenger: registrar.messenger())
    let instance = AdaChatFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    print("AdaChatFlutterPlugin:register: registrar=\(registrar)")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let method = call.method
    let arguments = call.arguments as? Dictionary<String, Any>
    let zendeskMessaging = ZendeskMessaging(flutterPlugin: self)

    print("AdaChatFlutterPlugin:handle: call=\(call), method=\(method), arguments=\(arguments)")

    switch(method){
      case "show":
          print("AdaChatFlutterPlugin:show: OK.\n")
          zendeskMessaging.show(rootViewController: UIApplication.shared.delegate?.window??.rootViewController)
          break
      default:
          break
    }

    result(nil)
  }
}
