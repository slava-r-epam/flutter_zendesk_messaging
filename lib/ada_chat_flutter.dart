import 'dart:async';
import 'dart:developer';

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
      log('AdaChat:initialize: error=$error');
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
      log('AdaChat:setLanguage: error=$error');
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
      log('AdaChat:setMetaFields: error=$error');
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
      log('AdaChat:setSensitiveMetaFields: error=$error');
    }
  }

  static Future<void> setDeviceToken({
    required String deviceToken,
  }) async {
    try {
      await _channel.invokeMethod(
        'setDeviceToken',
        <String, dynamic>{'deviceToken': deviceToken},
      );
    } catch (error) {
      log('AdaChat:setDeviceToken: error=$error');
    }
  }

  static Future<void> deleteHistory() async {
    try {
      await _channel.invokeMethod('deleteHistory');
    } catch (error) {
      log('AdaChat:deleteHistory: error=$error');
    }
  }

  static Future<void> triggerAnswer({
    required String answerId,
  }) async {
    try {
      await _channel.invokeMethod(
        'triggerAnswer',
        <String, dynamic>{'answerId': answerId},
      );
    } catch (error) {
      log('AdaChat:triggerAnswer: error=$error');
    }
  }

  static Future<void> reset() async {
    try {
      await _channel.invokeMethod('reset');
    } catch (error) {
      log('AdaChat:reset: error=$error');
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
      log('AdaChat:show: error=$error');
    }
  }
}
