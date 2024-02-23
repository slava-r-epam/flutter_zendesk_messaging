import 'dart:async';

import 'package:flutter/services.dart';

class AdaChat {
  static const MethodChannel _channel = MethodChannel('ada_chat');

  static Future<void> show({
    required String handle,
    String? cluster,
    String? greetings,
    String? deviceToken,
    String? language,
    int? loadTimeoutMillis,
    String? styles,
    bool? acceptThirdPartyCookies,
  }) async {
    try {
      await _channel.invokeMethod('show', <String, dynamic>{
        'handle': handle,
        'cluster': cluster,
        'greetings': greetings,
        'deviceToken': deviceToken,
        'language': language,
        'loadTimeoutMillis': loadTimeoutMillis,
        'styles': styles,
        'acceptThirdPartyCookies': acceptThirdPartyCookies,
      });
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
