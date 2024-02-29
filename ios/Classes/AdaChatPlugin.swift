import Flutter
import UIKit

enum CarError: Error {
  case noFuel
  case brokenEngine
  case check(fluid: String)
}

public class AdaChatPlugin: NSObject, FlutterPlugin {
  private static var channel: FlutterMethodChannel?
  private static var adaChatService: AdaChatService?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    debugPrint("AdaChatPlugin:register: registrar=\(registrar)")
    
    channel = FlutterMethodChannel(name: "ada_chat_flutter", binaryMessenger: registrar.messenger())
    let instance = AdaChatPlugin()
    
    registrar.addMethodCallDelegate(instance, channel: channel!)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let method = call.method
    let arguments = call.arguments as? Dictionary<String, Any>
    debugPrint("AdaChatPlugin:handle: call=\(call), method=\(method), arguments=\(String(describing: arguments))")
    
    switch(method){
    case "initialize":
      let handle = arguments!["handle"] as! String
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
      
      AdaChatPlugin.adaChatService = AdaChatService(flutterPlugin: self, channel: AdaChatPlugin.channel!)
      
      AdaChatPlugin.adaChatService!.initialize(handle: handle,
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
      
    case "show":
      if(AdaChatPlugin.adaChatService == nil) {
        print("AdaChatPlugin:show: adaChatService is not inited")
        break
      }
      
      let mode = arguments?["mode"] as? String
      
      AdaChatPlugin.adaChatService!.show(rootViewController: UIApplication.shared.delegate?.window??.rootViewController,
                                         mode: mode)
      break
      
    case "setLanguage":
      if(AdaChatPlugin.adaChatService == nil) {
        print("AdaChatPlugin:setLanguage: adaChatService is not inited")
        break
      }
      
      let language = arguments?["language"] as! String
      
      AdaChatPlugin.adaChatService!.setLanguage(language: language)
      break
      
    case "setMetaFields":
      if(AdaChatPlugin.adaChatService == nil) {
        print("AdaChatPlugin:setMetaFields: adaChatService is not inited")
        break
      }
      
      let metafields = arguments?["metafields"] as! [String : Any]
      
      AdaChatPlugin.adaChatService!.setMetaFields(metafields: metafields)
      break
      
    case "setSensitiveMetaFields":
      if(AdaChatPlugin.adaChatService == nil) {
        print("AdaChatPlugin:setSensitiveMetaFields: adaChatService is not inited")
        break
      }
      
      let metafields = arguments?["sensitiveMetafields"] as! [String : Any]
      
      AdaChatPlugin.adaChatService!.setSensitiveMetaFields(metafields: metafields)
      break
      
    case "deleteHistory":
      if(AdaChatPlugin.adaChatService == nil) {
        print("AdaChatPlugin:deleteHistory: adaChatService is not inited")
        break
      }
      
      AdaChatPlugin.adaChatService!.deleteHistory()
      break
      
    case "setDeviceToken":
      if(AdaChatPlugin.adaChatService == nil) {
        print("AdaChatPlugin:setDeviceToken: adaChatService is not inited")
        break
      }
      
      let deviceToken = arguments?["deviceToken"] as! String
      
      AdaChatPlugin.adaChatService!.setDeviceToken(deviceToken: deviceToken)
      break
      
    case "triggerAnswer":
      if(AdaChatPlugin.adaChatService == nil) {
        print("AdaChatPlugin:triggerAnswer: adaChatService is not inited")
        break
      }
      
      let answerId = arguments?["answerId"] as! String
      
      AdaChatPlugin.adaChatService!.triggerAnswer(answerId: answerId)
      break
      
    default:
      if(AdaChatPlugin.adaChatService == nil) {
        print("AdaChatPlugin:default: adaChatService is not inited")
        break
      }
      
      print("AdaChatPlugin:default: command=\(method) not found")
      break
    }
    
    result(nil)
  }
}
