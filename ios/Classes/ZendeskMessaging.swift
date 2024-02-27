import UIKit
import AdaEmbedFramework
import Flutter

public class ZendeskMessaging: NSObject {
//     private static var initializeSuccess: String = "initialize_success"
//     private static var initializeFailure: String = "initialize_failure"
//     private static var loginSuccess: String = "login_success"
//     private static var loginFailure: String = "login_failure"
//     private static var logoutSuccess: String = "logout_success"
//     private static var logoutFailure: String = "logout_failure"
    
//     let TAG = "[ZendeskMessaging]"
    
    private var zendeskPlugin: AdaChatFlutterPlugin? = nil
//     private var channel: FlutterMethodChannel? = nil

    init(flutterPlugin: AdaChatFlutterPlugin) {
      debugPrint("ZendeskMessaging:init")
      self.zendeskPlugin = flutterPlugin
//         self.channel = channel
    }

    func show(rootViewController: UIViewController?, 
              handle: String,
              cluster: String? = nil,
              language: String? = nil,
              domain: String? = nil,
              styles: String? = nil,
              greeting: String? = nil,
//              metafields: [String: Any]? = nil,
//              sensitiveMetafields: [String:Any] = nil,
              openWebLinksInSafari: Bool? = nil,
              appScheme: String? = nil,
//              zdChatterAuthCallback: (((@escaping (_ token: String) -> Void)) -> Void)? = nil,
//              webViewLoadingErrorCallback: ((Error) -> Void)? = nil,
//              eventCallbacks: [String: (_ event: [String: Any]) -> Void]? = nil,
              webViewTimeout: Double? = nil,
              deviceToken: String? = nil,
              navigationBarOpaqueBackground: Bool? = nil
              
    ) {
        debugPrint("ZendeskMessaging:show: rootViewController=\(String(describing: rootViewController)), handle=\(String(describing: handle)), cluster=\(String(describing: cluster)), language=\(String(describing: language)), domain=\(String(describing: domain)), styles=\(String(describing: styles)), greeting=\(String(describing: greeting)), openWebLinksInSafari=\(String(describing: openWebLinksInSafari)), appScheme=\(String(describing: appScheme)), webViewTimeout=\(String(describing: webViewTimeout)), deviceToken=\(String(describing: deviceToken)), navigationBarOpaqueBackground=\(String(describing: navigationBarOpaqueBackground))")
        
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
        
//        1 - Not working
//        adaFramework.launchInjectingWebSupport(into: rootViewController!.view)
        
//        2 - Not working
//        guard let navigationController = rootViewController?.navigationController else { return }
//        adaFramework.launchNavWebSupport(from: navigationController)
        
//        3 - Working
        if rootViewController == nil {
            return
        }
        adaFramework.launchModalWebSupport(from: rootViewController!)
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
