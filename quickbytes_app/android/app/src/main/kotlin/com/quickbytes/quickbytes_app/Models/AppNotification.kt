package com.quickbytes.quickbytes_app.Models

import Article
import io.flutter.app.FlutterMultiDexApplication
import kotlinx.serialization.*

enum class NotificationType {
    delivery,
    cancel,
}

@Serializable
data class AppNotification (
    val type: NotificationType,
    val article: Article,
    val id: Int = FlutterMultiDexApplication.notificationIdentifier.getNotificationId(article.id, type),
)
