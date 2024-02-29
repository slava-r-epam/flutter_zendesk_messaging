import UIKit
import AdaEmbedFramework
import Flutter

public class AdaChatService: NSObject {
  private var adaChatPlugin: AdaChatPlugin? = nil
  private var channel: FlutterMethodChannel? = nil
  private var adaFramework: AdaWebHost? = nil
  
  init(flutterPlugin: AdaChatPlugin, channel: FlutterMethodChannel) {
    self.adaChatPlugin = flutterPlugin
    self.channel = channel
  }
  
  func initialize(handle: String,
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
    debugPrint("AdaChatService:initialize: handle=\(String(describing: handle)), cluster=\(String(describing: cluster)), language=\(String(describing: language)), domain=\(String(describing: domain)), styles=\(String(describing: styles)), greeting=\(String(describing: greeting)), metafields=\(String(describing: metafields)), sensitiveMetafields=\(String(describing: sensitiveMetafields)), openWebLinksInSafari=\(String(describing: openWebLinksInSafari)), appScheme=\(String(describing: appScheme)), webViewTimeout=\(String(describing: webViewTimeout)), deviceToken=\(String(describing: deviceToken)), navigationBarOpaqueBackground=\(String(describing: navigationBarOpaqueBackground))")
    
    
    let adaFramework = AdaWebHost(handle: handle)
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
      let metafieldsBuilder = MetaFields.Builder()
      
      for pair in metafields! {
        let val = pair.value
        if val is String {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! String)
        } else if val is Bool {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! Bool)
        } else if val is Int {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! Int)
        } else if val is Float {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! Float)
        } else if val is Double {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! Double)
        } else {
          print("AdaChatService:show: incorrect metafield value=\(val) for key=\(pair.key)")
        }
      }
      
      adaFramework.setMetaFields(builder: metafieldsBuilder)
    }
    if sensitiveMetafields != nil {
      let metafieldsBuilder = MetaFields.Builder()
      
      for pair in metafields! {
        let val = pair.value
        if val is String {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! String)
        } else if val is Bool {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! Bool)
        } else if val is Int {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! Int)
        } else if val is Float {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! Float)
        } else if val is Double {
          _ = metafieldsBuilder.setField(key: pair.key, value: val as! Double)
        } else {
          print("AdaChatService:show: incorrect metafield value=\(val) for key=\(pair.key)")
        }
      }
      
      adaFramework.setSensitiveMetaFields(builder: metafieldsBuilder)
    }
    adaFramework.webViewLoadingErrorCallback = { (error) -> Void in
      self.channel?.invokeMethod("onError", arguments: error.localizedDescription)
    }
    adaFramework.eventCallbacks = ["*": { (event) -> Void in
      self.channel?.invokeMethod("onEvent", arguments: event)
    }]
    
    self.adaFramework = adaFramework
  }
  
  func show(rootViewController: UIViewController?,
            mode: String? = nil) {
    debugPrint("AdaChatService:show: rootViewController=\(String(describing: rootViewController)), mode=\(String(describing: mode))")
    
    if mode == "inject" {
      self.adaFramework!.launchInjectingWebSupport(into: rootViewController!.view)
    } else if mode == "navigation" {
      // fixme Not working
      if rootViewController?.navigationController == nil {
        print("AdaChatService:show: navigationController=nil")
        return
      }
      self.adaFramework!.launchNavWebSupport(from: rootViewController!.navigationController!)
    } else {
      if rootViewController == nil {
        print("AdaChatService:show: rootViewController=nil")
        return
      }
      self.adaFramework!.launchModalWebSupport(from: rootViewController!)
    }
  }
  
  func setLanguage(language: String) {
    if self.adaFramework == nil {
      print("AdaChatService:setLanguage: adaFramework is not initialized")
    }
    
    debugPrint("AdaChatService:setLanguage: language=\(String(describing: language))")
    
    self.adaFramework!.setLanguage(language: language)
  }
  
  func setMetaFields(metafields: [String:Any]) {
    if self.adaFramework == nil {
      print("AdaChatService:setMetaFields: adaFramework is not initialized")
    }
    
    debugPrint("AdaChatService:setMetaFields: metafields=\(String(describing: metafields))")
    
    let metafieldsBuilder = MetaFields.Builder()
    
    for pair in metafields {
      let val = pair.value
      if val is String {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! String)
      } else if val is Bool {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! Bool)
      } else if val is Int {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! Int)
      } else if val is Float {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! Float)
      } else if val is Double {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! Double)
      } else {
        print("AdaChatService:setMetaFields: incorrect metafield value=\(val) for key=\(pair.key)")
      }
    }
    
    self.adaFramework!.setMetaFields(builder: metafieldsBuilder)
  }
  
  func setSensitiveMetaFields(metafields: [String:Any]) {
    if self.adaFramework == nil {
      print("AdaChatService:setSensitiveMetaFields: adaFramework is not initialized")
    }
    
    debugPrint("AdaChatService:setSensitiveMetaFields: metafields=\(String(describing: metafields))")
    
    let metafieldsBuilder = MetaFields.Builder()
    
    for pair in metafields {
      let val = pair.value
      if val is String {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! String)
      } else if val is Bool {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! Bool)
      } else if val is Int {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! Int)
      } else if val is Float {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! Float)
      } else if val is Double {
        _ = metafieldsBuilder.setField(key: pair.key, value: val as! Double)
      } else {
        print("AdaChatService:setSensitiveMetaFields: incorrect metafield value=\(val) for key=\(pair.key)")
      }
    }
    
    self.adaFramework!.setSensitiveMetaFields(builder: metafieldsBuilder)
  }
  
  
  func deleteHistory() {
    if self.adaFramework == nil {
      print("AdaChatService:deleteHistory: adaFramework is not initialized")
    }
    
    debugPrint("AdaChatService:deleteHistory")
    
    self.adaFramework!.deleteHistory()
  }
  
  func setDeviceToken(deviceToken: String) {
    if self.adaFramework == nil {
      print("AdaChatService:setDeviceToken: adaFramework is not initialized")
    }
    
    debugPrint("AdaChatService:setDeviceToken: deviceToken=\(String(describing: deviceToken))")
    
    self.adaFramework!.setDeviceToken(deviceToken: deviceToken)
  }
  
  func triggerAnswer(answerId: String) {
    if self.adaFramework == nil {
      print("AdaChatService:triggerAnswer: adaFramework is not initialized")
    }
    
    debugPrint("AdaChatService:triggerAnswer: answerId=\(String(describing: answerId))")
    
    self.adaFramework!.triggerAnswer(answerId: answerId)
  }
  
  func reset() {
    if self.adaFramework == nil {
      print("AdaChatService:reset: adaFramework is not initialized")
    }
    
    debugPrint("AdaChatService:reset")
    
    self.adaFramework!.reset()
  }
}
