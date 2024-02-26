package com.headspace.ada_chat_flutter

import AdaChatService
import android.app.Activity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class AdaChatPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    var activity: Activity? = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val sendData: Any? = call.arguments
        val adaChatMessaging = AdaChatService(this, channel)

        println("AdaChatPlugin:onMethodCall: call=$call, method=${call.method}, arguments=${call.arguments}")

        when (call.method) {
            "show" -> {
                val handle = call.argument<String>("handle")!!
                val cluster = call.argument<String>("cluster")
                val greetings = call.argument<String>("greetings")
                val deviceToken = call.argument<String>("deviceToken")
                val language = call.argument<String>("language")
                val loadTimeoutMillis = call.argument<Int>("loadTimeoutMillis")
                val styles = call.argument<String>("styles")
                val acceptThirdPartyCookies = call.argument<Boolean>("acceptThirdPartyCookies")

                println("AdaChatPlugin:show: handle=$handle, cluster=$cluster, " +
                        "greetings=$greetings, deviceToken=$deviceToken, language=$language, " +
                        "handle=$handle, loadTimeoutMillis=$loadTimeoutMillis, styles=$styles, " +
                        "acceptThirdPartyCookies=$acceptThirdPartyCookies")
                adaChatMessaging.show(
                        handle,
                        cluster,
                        greetings,
                        deviceToken,
                        language,
                        loadTimeoutMillis,
                        styles,
                        acceptThirdPartyCookies,
                )
            }
//            "initialize" -> {
//                if (isInitialized) {
//                    println("$tag - Messaging is already initialized!")
//                    return
//                }
//                val channelKey = call.argument<String>("channelKey")!!
//                zendeskMessaging.initialize(channelKey)
//            }
//            "show" -> {
//                if (!isInitialized) {
//                    println("$tag - Messaging needs to be initialized first")
//                    return
//                }
//                zendeskMessaging.show()
//            }
//            "isInitialized" -> {
//                result.success(isInitialized)
//            }
//            "loginUser" -> {
//                if (!isInitialized) {
//                    println("$tag - Messaging needs to be initialized first")
//                    return
//                }
//
//                try {
//                    val jwt = call.argument<String>("jwt")
//                    if (jwt == null || jwt.isEmpty()) {
//                        throw Exception("JWT is empty or null")
//                    }
//                    zendeskMessaging.loginUser(jwt)
//                } catch (err: Throwable) {
//                    println("$tag - Messaging::login invalid arguments. {'jwt': '<your_jwt>'} expected !")
//                    println(err.message)
//                    return
//                }
//            }
//            "logoutUser" -> {
//                if (!isInitialized) {
//                    println("$tag - Messaging needs to be initialized first")
//                    return
//                }
//                zendeskMessaging.logoutUser()
//            }
//            "getUnreadMessageCount" -> {
//                if (!isInitialized) {
//                    println("$tag - Messaging needs to be initialized first")
//                    return
//                }
//                result.success(zendeskMessaging.getUnreadMessageCount())
//            }
            else -> {
                result.notImplemented()
            }
        }

        if (sendData != null) {
            result.success(sendData)
        } else {
            result.success(0)
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ada_chat_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

}