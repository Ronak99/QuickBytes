package com.quickbytes.quickbytes_app

import com.quickbytes.quickbytes_app.Constants.kPlatformChannel
import com.quickbytes.quickbytes_app.Constants.kPlatformEventChannel
import com.quickbytes.quickbytes_app.Constants.kPlatformMethodInitializeEventStream
import io.flutter.app.FlutterMultiDexApplication
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(), EventChannel.StreamHandler {

    private var streamHandler: EventChannel.StreamHandler = this

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, kPlatformChannel).apply {
            setMethodCallHandler { call, result ->
                if (call.method == kPlatformMethodInitializeEventStream) {
                    val event = EventChannel(flutterEngine.dartExecutor.binaryMessenger, kPlatformEventChannel)
                    event.setStreamHandler(streamHandler)
                    result.success(true)
                }
                if (call.method == "get_pending_notifications") {
                    result.success(FlutterMultiDexApplication.pendingNotificationList);
                    FlutterMultiDexApplication.resetPendingNotificationList();
                }
                if (call.method == "reset_pending_notifications") {
                    FlutterMultiDexApplication.resetPendingNotificationList();
                    result.success(true)
                }
                if (call.method == "crash_app") {
                    throw RuntimeException("Native Crash")
                }
            }
        }
    }

    override fun onListen(p0: Any?, events: EventChannel.EventSink?) {
        FlutterMultiDexApplication.initializeEventSink(events)
    }

    override fun onCancel(p0: Any?) {
        TODO("Not yet implemented")
    }

}
