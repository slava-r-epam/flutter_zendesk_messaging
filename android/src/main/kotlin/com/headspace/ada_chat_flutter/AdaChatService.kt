import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.FragmentActivity
import com.headspace.ada_chat_flutter.AdaChatPlugin
import io.flutter.plugin.common.MethodChannel
import support.ada.embed.ui.legacy.AdaEmbedActivity
import support.ada.embed.ui.legacy.AdaEmbedDialog
import support.ada.embed.widget.AdaEmbedView


class AdaChatService(private val plugin: AdaChatPlugin, private val channel: MethodChannel) {
    fun show(
            handle: String,
            cluster: String?,
            greetings: String?,
            deviceToken: String?,
            language: String?,
            loadTimeoutMillis: Int?,
            styles: String?,
            acceptThirdPartyCookies: Boolean?,
    ) {
        println("AdaChatService:show: handle=$handle, cluster=$cluster, greetings=$greetings, " +
                "deviceToken=$deviceToken, language=$language, loadTimeoutMillis=$loadTimeoutMillis, " +
                "styles=$styles, acceptThirdPartyCookies=$acceptThirdPartyCookies")

        val activity = plugin.activity!!;
        println("AdaChatService:show: activity=$activity");

        val adaSettingsBuilder = AdaEmbedView.Settings.Builder(handle)
        if (cluster != null) {
            adaSettingsBuilder.cluster(cluster)
        }
        if (greetings != null) {
            adaSettingsBuilder.greetings(greetings)
        }
        if (deviceToken != null) {
            adaSettingsBuilder.deviceToken(deviceToken)
        }
        if (language != null) {
            adaSettingsBuilder.language(language)
        }
        if (loadTimeoutMillis != null) {
            adaSettingsBuilder.loadTimeoutMillis(loadTimeoutMillis)
        }
        if (styles != null) {
            adaSettingsBuilder.styles(styles)
        }
        if (acceptThirdPartyCookies != null) {
            adaSettingsBuilder.acceptThirdPartyCookies(acceptThirdPartyCookies)
        }
//        if (metaFields != null) { // todo metaFields
//            adaSettingsBuilder.metaFields(metaFields)
//        }
//        if (sensitiveMetaFields != null) { // todo sensitiveMetaFields
//            adaSettingsBuilder.sensitiveMetaFields(sensitiveMetaFields)
//        }

        val adaSettings = adaSettingsBuilder.build()

//        val adaView = AdaEmbedView(activity)
//        adaView.initialize(adaSettings)

//        val dialog = AdaEmbedDialog()
//        dialog.arguments = Bundle().apply {
//            putParcelable(AdaEmbedDialog.ARGUMENT_SETTINGS, adaSettings)
//        }
//
//        dialog.show((activity as FragmentActivity).supportFragmentManager, AdaEmbedDialog.TAG)

        val context = activity.applicationContext;
        val intent = Intent(context, AdaEmbedActivity::class.java)
        intent.putExtra(AdaEmbedActivity.EXTRA_SETTINGS, adaSettings)
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)

    }

//    fun initialize(channelKey: String) {
//        println("$tag - Channel Key - $channelKey")
//        Zendesk.initialize(
//            plugin.activity!!,
//            channelKey,
//            successCallback = { value ->
//                plugin.isInitialized = true;
//                println("$tag - initialize success - $value")
//                channel.invokeMethod(initializeSuccess, null)
//            },
//            failureCallback = { error ->
//                plugin.isInitialized = false;
//                println("$tag - initialize failure - $error")
//                channel.invokeMethod(initializeFailure, mapOf("error" to error.message))
//            },
//            messagingFactory = DefaultMessagingFactory()
//        )
//    }
//
//    fun show() {
//        Zendesk.instance.messaging.showMessaging(plugin.activity!!, Intent.FLAG_ACTIVITY_NEW_TASK)
//        println("$tag - show")
//    }
//    fun getUnreadMessageCount(): Int {
//        return try {
//            Zendesk.instance.messaging.getUnreadMessageCount()
//        }catch (error: Throwable){
//            0
//        }
//    }
//
//    fun loginUser(jwt: String) {
//        Zendesk.instance.loginUser(
//            jwt,
//            { value: ZendeskUser? ->
//                value?.let {
//                    channel.invokeMethod(loginSuccess, mapOf("id" to it.id, "externalId" to it.externalId))
//                } ?: run {
//                    channel.invokeMethod(loginSuccess, mapOf("id" to null, "externalId" to null))
//                }
//            },
//            { error: Throwable? ->
//                println("$tag - Login failure : ${error?.message}")
//                println(error)
//                channel.invokeMethod(loginFailure, mapOf("error" to error?.message))
//            })
//    }
//
//    fun logoutUser() {
//        GlobalScope.launch (Dispatchers.Main)  {
//            try {
//                val result = Zendesk.instance.logoutUser()
//                if (result is ZendeskResult.Failure) {
//                    channel.invokeMethod(logoutFailure, null)
//                } else {
//                    channel.invokeMethod(logoutSuccess, null)
//                }
//            } catch (error: Throwable) {
//                println("$tag - Logout failure : ${error.message}")
//                channel.invokeMethod(logoutFailure, mapOf("error" to error.message))
//            }
//        }
//    }
}


