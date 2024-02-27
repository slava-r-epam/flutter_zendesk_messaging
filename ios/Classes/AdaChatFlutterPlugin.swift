import Flutter
import UIKit

public class AdaChatFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ada_chat_flutter", binaryMessenger: registrar.messenger())
    let instance = AdaChatFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    debugPrint("AdaChatFlutterPlugin:register: registrar=\(registrar)")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let method = call.method
    let arguments = call.arguments as? Dictionary<String, Any>
    let zendeskMessaging = ZendeskMessaging(flutterPlugin: self)

      debugPrint("AdaChatFlutterPlugin:handle: call=\(call), method=\(method), arguments=\(String(describing: arguments))")

    switch(method){
      case "show":
        let handle = arguments!["handle"] as! String
        let cluster = arguments?["cluster"] as? String
        let language = arguments?["language"] as? String
        let domain = arguments?["domain"] as? String
        let styles = arguments?["styles"] as? String
        let greeting = arguments?["greeting"] as? String
        let openWebLinksInSafari = arguments?["openWebLinksInSafari"] as? Bool
        let appScheme = arguments?["appScheme"] as? String
        let webViewTimeout = arguments?["webViewTimeout"] as? Double
        let deviceToken = arguments?["deviceToken"] as? String
        let navigationBarOpaqueBackground = arguments?["navigationBarOpaqueBackground"] as? Bool
        
        debugPrint("AdaChatFlutterPlugin:show: handle=\(handle), cluster=\(String(describing: cluster)), language=\(String(describing: language)), domain=\(String(describing: domain)), styles=\(String(describing: styles)), greeting=\(String(describing: greeting)), openWebLinksInSafari=\(String(describing: openWebLinksInSafari)), appScheme=\(String(describing: appScheme)), webViewTimeout=\(String(describing: webViewTimeout)), deviceToken=\(String(describing: deviceToken)), navigationBarOpaqueBackground=\(String(describing: navigationBarOpaqueBackground))")

        
        zendeskMessaging.show(rootViewController: UIApplication.shared.delegate?.window??.rootViewController, handle: handle, cluster: cluster, language: language, domain: domain, styles: styles, greeting: greeting, openWebLinksInSafari: openWebLinksInSafari, appScheme: appScheme, webViewTimeout: webViewTimeout, deviceToken: deviceToken, navigationBarOpaqueBackground: navigationBarOpaqueBackground)
          break
      default:
          break
    }

    result(nil)
  }
}
