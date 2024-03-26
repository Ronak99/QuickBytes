package com.quickbytes.quickbytes_app.Utils

import android.util.Log
import com.quickbytes.quickbytes_app.Models.NotificationCategory
import java.util.Random

class NotificationIdentifier {
    private val TAG = "NotificationIdentifier"

    private val deliveryNotificationMap: MutableMap<String, Int>
    private val deliveredNotificationMap: MutableMap<String, Int>

    init {
        deliveryNotificationMap = HashMap()
        deliveredNotificationMap = HashMap();
    }

    private fun addToNotificationMap(key: String, value: Int) {
        deliveryNotificationMap[key] = value
    }

    private fun containsKey(key: String, map: MutableMap<String, Int>): Boolean {
        return map.containsKey(key)
    }

    fun hasBeenDelivered(key: String): Boolean {
        return deliveredNotificationMap.containsKey(key)
    }

    fun getValue(key: String, map: MutableMap<String, Int>): Int {
        return map[key] ?: 0
    }

    fun getNotificationId(itemId: String, category: NotificationCategory): Int {
        val map: MutableMap<String, Int> = when (category) {
            NotificationCategory.cancelNews -> {
                deliveredNotificationMap
            }
            else -> {
                deliveryNotificationMap
            }
        }

        return if (containsKey(itemId, map)) {
            getValue(itemId, map)
        } else {
            // user will only ever reach this map in case of type being NotificationType.delivery
            // in case of NotificationType.cancel, this notification would've already been delivered
            val generatedNotificationId: Int = Random().nextInt(1000)
            addToNotificationMap(itemId, generatedNotificationId)
            generatedNotificationId
        }
    }

    fun markAsDelivered(key:String) {
        deliveredNotificationMap[key] = deliveryNotificationMap[key] ?: 0
        deliveryNotificationMap.remove(key)
    }
}