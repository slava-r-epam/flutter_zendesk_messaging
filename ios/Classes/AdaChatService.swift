import UIKit
import AdaEmbedFramework
import Flutter

public class AdaChatService: NSObject {
    private var adaChatPlugin: AdaChatPlugin? = nil
    private var channel: FlutterMethodChannel? = nil

    init(flutterPlugin: AdaChatPlugin, channel: FlutterMethodChannel) {
      debugPrint("AdaChatService:init")
      self.adaChatPlugin = flutterPlugin
      self.channel = channel
    }

    func show(rootViewController: UIViewController?, 
              handle: String,
              mode: String? = nil,
              cluster: String? = nil,
              language: String? = nil,
              domain: String? = nil,
              styles: String? = nil,
              greeting: String? = nil,
              metafields: [String: Any]? = nil,
              sensitiveMetafields: [String:Any]? = nil,
              openWebLinksInSafari: Bool? = nil,
              appScheme: String? = nil,
              webViewTimeout: Double? = nil,
              deviceToken: String? = nil,
              navigationBarOpaqueBackground: Bool? = nil) {
        debugPrint("AdaChatService:show: rootViewController=\(String(describing: rootViewController)), handle=\(String(describing: handle)), mode=\(String(describing: mode)), cluster=\(String(describing: cluster)), language=\(String(describing: language)), domain=\(String(describing: domain)), styles=\(String(describing: styles)), greeting=\(String(describing: greeting)), metafields=\(String(describing: metafields)), sensitiveMetafields=\(String(describing: sensitiveMetafields)), openWebLinksInSafari=\(String(describing: openWebLinksInSafari)), appScheme=\(String(describing: appScheme)), webViewTimeout=\(String(describing: webViewTimeout)), deviceToken=\(String(describing: deviceToken)), navigationBarOpaqueBackground=\(String(describing: navigationBarOpaqueBackground))")
        
        channel?.invokeMethod("callback1", arguments: ["key1": "value1"])
        
        lazy var adaFramework = AdaWebHost(handle: handle)
        if cluster != nil {
            adaFramework.cluster = cluster!
        }
        if language != nil {
            adaFramework.language = language!
        }
        if domain != nil {
            adaFramework.domain = domain!
        }
        if styles != nil {
            adaFramework.styles = styles!
        }
        if greeting != nil {
            adaFramework.greeting = greeting!
        }
        if openWebLinksInSafari != nil {
            adaFramework.openWebLinksInSafari = openWebLinksInSafari!
        }
        if appScheme != nil {
            adaFramework.appScheme = appScheme!
        }
        if webViewTimeout != nil {
            adaFramework.webViewTimeout = webViewTimeout!
        }
        if deviceToken != nil {
            adaFramework.deviceToken = deviceToken!
        }
        if navigationBarOpaqueBackground != nil {
            adaFramework.navigationBarOpaqueBackground = navigationBarOpaqueBackground!
        }
        if deviceToken != nil {
            adaFramework.deviceToken = deviceToken!
        }
        if metafields != nil {
            for pair in metafields! {
                let val = pair.value
                if val is String {
                    adaFramework.setMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! String))
                } else if val is Bool {
                    adaFramework.setMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! Bool))
                } else if val is Int {
                    adaFramework.setMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! Int))
                } else if val is Float {
                    adaFramework.setMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! Float))
                } else if val is Double {
                    adaFramework.setMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! Double))
                } else {
                    print("AdaChatService:show: incorrect metafield value=\(val) for key=\(pair.key)")
                }
            }
        }
        if sensitiveMetafields != nil {
            for pair in sensitiveMetafields! {
                let val = pair.value
                if val is String {
                    adaFramework.setSensitiveMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! String))
                } else if val is Bool {
                    adaFramework.setSensitiveMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! Bool))
                } else if val is Int {
                    adaFramework.setSensitiveMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! Int))
                } else if val is Float {
                    adaFramework.setSensitiveMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! Float))
                } else if val is Double {
                    adaFramework.setSensitiveMetaFields(builder: MetaFields.Builder().setField(key: pair.key, value: val as! Double))
                } else {
                    print("AdaChatService:show: incorrect sensitiveMetafield value=\(val) for key=\(pair.key)")
                }
            }
        }
        
        adaFramework.webViewLoadingErrorCallback = { (error) -> Void in
            self.channel?.invokeMethod("onError", arguments: error)
        }
        adaFramework.eventCallbacks = ["*": { (event) -> Void in
            self.channel?.invokeMethod("onEvent", arguments: event)
        }]
    
//        public var zdChatterAuthCallback: (((@escaping (_ token: String) -> Void)) -> Void)?
//              zdChatterAuthCallback: (((@escaping (_ token: String) -> Void)) -> Void)? = nil,
        
        if mode == "inject" {
            adaFramework.launchInjectingWebSupport(into: rootViewController!.view)
        } else if mode == "navigation" {
            if rootViewController?.navigationController == nil {
                print("AdaChatService:show: navigationController=nil")
                return
            }
            adaFramework.launchNavWebSupport(from: rootViewController!.navigationController!)
        } else {
            if rootViewController == nil {
                print("AdaChatService:show: rootViewController=nil")
                return
            }
            adaFramework.launchModalWebSupport(from: rootViewController!)
        }
    }

//     func initialize(channelKey: String) {
//         debugPrint("ZendeskMessaging:initialize - Channel Key - \(channelKey)\n")
//         Zendesk.initialize(withChannelKey: channelKey, messagingFactory: DefaultMessagingFactory()) { result in
//             if case let .failure(error) = result {
//                 self.zendeskPlugin?.isInitialized = false
//                 debugPrint("\(self.TAG) - initialize failure - \(error.localizedDescription)\n")
//                 self.channel?.invokeMethod(ZendeskMessaging.initializeFailure, arguments: ["error": error.localizedDescription])
//             } else {
//                 self.zendeskPlugin?.isInitialized = true
//                 debugPrint("\(self.TAG) - initialize success")
//                 self.channel?.invokeMethod(ZendeskMessaging.initializeSuccess, arguments: [:])
//             }
//         }
//     }

//     func show(rootViewController: UIViewController?) {
//         guard let messagingViewController = Zendesk.instance?.messaging?.messagingViewController() else { return }
//         guard let rootViewController = rootViewController else { return }
//         rootViewController.present(messagingViewController, animated: true, completion: nil)
//         debugPrint("\(self.TAG) - show")
//     }
//
//     func loginUser(jwt: String) {
//         Zendesk.instance?.loginUser(with: jwt) { result in
//             switch result {
//             case .success(let user):
//                 self.channel?.invokeMethod(ZendeskMessaging.loginSuccess, arguments: ["id": user.id, "externalId": user.externalId])
//                 break;
//             case .failure(let error):
//                 debugPrint("\(self.TAG) - login failure - \(error.localizedDescription)\n")
//                 self.channel?.invokeMethod(ZendeskMessaging.loginFailure, arguments: ["error": nil])
//                 break;
//             }
//         }
//     }
//
//     func logoutUser() {
//         Zendesk.instance?.logoutUser { result in
//             switch result {
//             case .success:
//                 self.channel?.invokeMethod(ZendeskMessaging.logoutSuccess, arguments: [])
//                 break;
//             case .failure(let error):
//                 debugPrint("\(self.TAG) - logout failure - \(error.localizedDescription)\n")
//                 self.channel?.invokeMethod(ZendeskMessaging.logoutFailure, arguments: ["error": nil])
//                 break;
//             }
//         }
//     }
//     func getUnreadMessageCount() -> Int {
//         let count = Zendesk.instance?.messaging?.getUnreadMessageCount()
//         return count ?? 0
//     }
}
