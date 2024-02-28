import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AdaChat {
  static const MethodChannel _channel = MethodChannel('ada_chat_flutter');

  AdaChat() {
    _channel.setMethodCallHandler((call) async {
      final method = call.method;

      if (method == 'onEvent') {
        debugPrint('AdaChat:onCallback:onEvent: arguments=${call.arguments}');
      } else if (method == 'onError') {
        debugPrint('AdaChat:onCallback:onError: arguments=${call.arguments}');
      } else {
        debugPrint('AdaChat:onCallback: method=$method, '
            'arguments=${call.arguments}');
      }
    });
  }

  static Future<void> initialize({
    required String handle,
    String? cluster,
    String? greetings,

    /// Object can be bool, int, double or String
    Map<String, Object>? metafields,

    /// Object can be bool, int, double or String
    Map<String, Object>? sensitiveMetafields,
    String? deviceToken,
    String? language,
    int? loadTimeoutMillis,
    String? styles,

    /// Android only
    bool? acceptThirdPartyCookies,

    /// iOS only
    bool? openWebLinksInSafari,

    /// iOS only
    String? appScheme,

    /// iOS only
    bool? navigationBarOpaqueBackground,

    /// iOS only
    String? domain,
  }) async {
    try {
      await _channel.invokeMethod('initialize', <String, dynamic>{
        'handle': handle,
        'cluster': cluster,
        'greetings': greetings,
        'deviceToken': deviceToken,
        'metafields': metafields,
        'sensitiveMetafields': sensitiveMetafields,
        'language': language,
        'loadTimeoutMillis': loadTimeoutMillis,
        'webViewTimeout':
            loadTimeoutMillis == null ? null : loadTimeoutMillis / 1000,
        'styles': styles,
        'acceptThirdPartyCookies': acceptThirdPartyCookies,
        'openWebLinksInSafari': openWebLinksInSafari,
        'appScheme': appScheme,
        'navigationBarOpaqueBackground': navigationBarOpaqueBackground,
        'domain': domain,
      });
    } catch (error) {
      print('AdaChat:initialize: error=$error');
    }
  }

  static Future<void> setLanguage({
    required String language,
  }) async {
    try {
      await _channel.invokeMethod(
        'setLanguage',
        <String, dynamic>{'language': language},
      );
    } catch (error) {
      print('AdaChat:setLanguage: error=$error');
    }
  }

  static Future<void> setMetaFields({
    /// Object can be bool, int, double or String
    required Map<String, Object> metafields,
  }) async {
    try {
      await _channel.invokeMethod(
        'setMetaFields',
        <String, dynamic>{'metafields': metafields},
      );
    } catch (error) {
      print('AdaChat:setMetaFields: error=$error');
    }
  }

  static Future<void> setSensitiveMetaFields({
    /// Object can be bool, int, double or String
    required Map<String, Object> sensitiveMetafields,
  }) async {
    try {
      await _channel.invokeMethod(
        'setSensitiveMetaFields',
        <String, dynamic>{'sensitiveMetafields': sensitiveMetafields},
      );
    } catch (error) {
      print('AdaChat:setSensitiveMetaFields: error=$error');
    }
  }

  static Future<void> show({
    /// iOS only, possible values are 'inject', 'navigation' and 'modal' (default).
    String? mode,
  }) async {
    try {
      await _channel.invokeMethod(
        'show',
        <String, dynamic>{'mode': mode},
      );
    } catch (error) {
      print('AdaChat:show: error=$error');
    }
  }

  /// Authenticate the current session with a JWT
  ///
  /// @param  jwt       Required by the SDK - You must generate it from your backend
  /// @param  onSuccess Optional - If you need to be notified about the login success
  /// @param  onFailure Optional - If you need to be notified about the login failure
  // static Future<void> loginUserCallbacks(
  //     {required String jwt,
  //     Function(String? id, String? externalId)? onSuccess,
  //     Function()? onFailure}) async {
  //   if (jwt.isEmpty) {
  //     debugPrint('ZendeskMessaging - loginUser - jwt can not be empty');
  //     return;
  //   }
  //
  //   try {
  //     _setObserver(
  //         ZendeskMessagingMessageType.loginSuccess,
  //         onSuccess != null
  //             ? (Map? args) => onSuccess(args?["id"], args?["externalId"])
  //             : null);
  //     _setObserver(ZendeskMessagingMessageType.loginFailure,
  //         onFailure != null ? (Map? args) => onFailure() : null);
  //
  //     await _channel.invokeMethod('loginUser', {'jwt': jwt});
  //   } catch (e) {
  //     debugPrint('ZendeskMessaging - loginUser - Error: $e}');
  //   }
  // }

  /// Helper function to login waiting for future to complete
  ///
  /// @return   The zendesk userId
  // static Future<ZendeskLoginResponse> loginUser({required String jwt}) async {
  //   var completer = Completer<ZendeskLoginResponse>();
  //   await loginUserCallbacks(
  //     jwt: jwt,
  //     onSuccess: (id, externalId) =>
  //         completer.complete(ZendeskLoginResponse(id, externalId)),
  //     onFailure: () =>
  //         completer.completeError(Exception("Zendesk::loginUser failed")),
  //   );
  //   return completer.future;
  // }

  /// Logout the currently authenticated user
  ///
  /// @param  onSuccess Optional - If you need to be notified about the logout success
  /// @param  onFailure Optional - If you need to be notified about the logout failure
  // static Future<void> logoutUserCallbacks(
  //     {Function()? onSuccess, Function()? onFailure}) async {
  //   try {
  //     _setObserver(ZendeskMessagingMessageType.logoutSuccess,
  //         onSuccess != null ? (Map? args) => onSuccess() : null);
  //     _setObserver(ZendeskMessagingMessageType.logoutFailure,
  //         onFailure != null ? (Map? args) => onFailure() : null);
  //
  //     await _channel.invokeMethod('logoutUser');
  //   } catch (e) {
  //     debugPrint('ZendeskMessaging - logoutUser - Error: $e}');
  //   }
  // }

  /// Helper function to logout waiting for future to complete
  // static Future<void> logoutUser() async {
  //   var completer = Completer<void>();
  //   await logoutUserCallbacks(
  //     onSuccess: () => completer.complete(),
  //     onFailure: () =>
  //         completer.completeError(Exception("Zendesk::logoutUser failed")),
  //   );
  //   return completer.future;
  // }

  /// Retrieve uread messages count from the Zendesk SDK
  // static Future<int> getUnreadMessageCount() async {
  //   try {
  //     return await _channel.invokeMethod(
  //       'getUnreadMessageCount',
  //     );
  //   } catch (e) {
  //     debugPrint('ZendeskMessaging - count - Error: $e}');
  //     return 0;
  //   }
  // }

  ///  Check if the Zendesk SDK for Android and iOS is already initialized
  // static Future<bool> isInitialized() async {
  //   try {
  //     return await _channel.invokeMethod(
  //       'isInitialized',
  //     );
  //   } catch (e) {
  //     debugPrint('ZendeskMessaging - isInitialized - Error: $e}');
  //     return false;
  //   }
  // }

  /// Handle incoming message from platforms (iOS and Android)
  // static Future<dynamic> _onMethodCall(final MethodCall call) async {
  //   if (!channelMethodToMessageType.containsKey(call.method)) {
  //     return;
  //   }
  //
  //   final ZendeskMessagingMessageType type =
  //       channelMethodToMessageType[call.method]!;
  //   var globalHandler = _handler;
  //   if (globalHandler != null) {
  //     globalHandler(type, call.arguments);
  //   }
  //
  //   // call all observers too
  //   final ZendeskMessagingObserver? observer = _observers[type];
  //   if (observer != null) {
  //     observer.func(call.arguments);
  //     if (observer.removeOnCall) {
  //       _setObserver(type, null);
  //     }
  //   }
  // }

  /// Add an observer for a specific type
  // static _setObserver(
  //     ZendeskMessagingMessageType type, Function(Map? args)? func,
  //     {bool removeOnCall = true}) {
  //   if (func == null) {
  //     _observers.remove(type);
  //   } else {
  //     _observers[type] = ZendeskMessagingObserver(removeOnCall, func);
  //   }
  // }
}
