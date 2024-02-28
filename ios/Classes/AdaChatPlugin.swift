import Flutter
import UIKit

public class AdaChatPlugin: NSObject, FlutterPlugin {
  private static var channel: FlutterMethodChannel?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    channel = FlutterMethodChannel(name: "ada_chat_flutter", binaryMessenger: registrar.messenger())
    let instance = AdaChatPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel!)

    debugPrint("AdaChatPlugin:register: registrar=\(registrar)")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let method = call.method
    let arguments = call.arguments as? Dictionary<String, Any>
      let adaChatService = AdaChatService(flutterPlugin: self, channel: AdaChatPlugin.channel!)

    debugPrint("AdaChatPlugin:handle: call=\(call), method=\(method), arguments=\(String(describing: arguments))")

    switch(method){
      case "show":
        let handle = arguments!["handle"] as! String
        let mode = arguments?["mode"] as? String
        let cluster = arguments?["cluster"] as? String
        let language = arguments?["language"] as? String
        let domain = arguments?["domain"] as? String
        let styles = arguments?["styles"] as? String
        let greeting = arguments?["greeting"] as? String
        let metafields = arguments?["metafields"] as? [String : Any]
        let sensitiveMetafields = arguments?["sensitiveMetafields"] as? [String : Any]
        let openWebLinksInSafari = arguments?["openWebLinksInSafari"] as? Bool
        let appScheme = arguments?["appScheme"] as? String
        let webViewTimeout = arguments?["webViewTimeout"] as? Double
        let deviceToken = arguments?["deviceToken"] as? String
        let navigationBarOpaqueBackground = arguments?["navigationBarOpaqueBackground"] as? Bool
            
        adaChatService.show(rootViewController: UIApplication.shared.delegate?.window??.rootViewController,
                            handle: handle,
                            mode: mode,
                            cluster: cluster,
                            language: language,
                            domain: domain,
                            styles: styles,
                            greeting: greeting,
                            metafields: metafields,
                            sensitiveMetafields: sensitiveMetafields,
                            openWebLinksInSafari: openWebLinksInSafari,
                            appScheme: appScheme,
                            webViewTimeout: webViewTimeout,
                            deviceToken: deviceToken,
                            navigationBarOpaqueBackground: navigationBarOpaqueBackground)
        break
      default:
        print("AdaChatPlugin:handle: command=\(method) not found")
        break
    }

    result(nil)
  }
}
