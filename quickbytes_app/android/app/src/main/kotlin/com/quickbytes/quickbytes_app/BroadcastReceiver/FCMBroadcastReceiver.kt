package com.quickbytes.quickbytes_app.BroadcastReceiver

import android.annotation.SuppressLint
import android.content.Intent
import android.util.Log
//import com.quickbytes.quickbytes_app.Services.NotificationService
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.quickbytes.quickbytes_app.Models.NewsNotification
import com.quickbytes.quickbytes_app.Services.NotificationService
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json


class FCMBroadcastReceiver : FirebaseMessagingService() {
    val TAG: String = "FCMBroadcastReceiver"

    @SuppressLint("WrongConstant")
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        Log.d(TAG, "Message received")
        val json = Json { ignoreUnknownKeys = true }
        val payloadIsEmpty = remoteMessage.data.isEmpty()

        if (payloadIsEmpty) {
            Log.d(TAG, "Payload was empty")
            return
        }

        Log.d(TAG, "Payload is not empty")
        val payload = remoteMessage.data

        val newsNotification = json.decodeFromString<NewsNotification>(payload["data"] as String)

        if (newsNotification.isValid) {
            val notificationService = NotificationService(applicationContext)
            notificationService.dispatchNotification(newsNotification)
        }
    }

    override fun onMessageSent(s: String) {
        super.onMessageSent(s)
        Log.d(TAG, "Message has been sent")
    }

    override fun onTaskRemoved(rootIntent: Intent) {
        Log.e(TAG, "Task has been removed")
    }

    override fun onDestroy() {
        Log.d(TAG, "Task has been destroyed")
        super.onDestroy()
    }

    override fun onLowMemory() {
        super.onLowMemory()
        Log.d(TAG, "Device is on low memory")
    }

    override fun handleIntentOnMainThread(intent: Intent): Boolean {
        super.handleIntentOnMainThread(intent)
        return false
    }

    companion object {
        private const val TAG = "FCM Trigger"
    }
}