package com.quickbytes.quickbytes_app.Models

import Article
import io.flutter.app.FlutterMultiDexApplication
import kotlinx.serialization.*

enum class NotificationCategory {
    deliverNews,
    cancelNews,
}

@Serializable
data class NewsNotification (
    val category: NotificationCategory,
    val article: Article,
    val id: Int = FlutterMultiDexApplication.notificationIdentifier.getNotificationId(article.id, category),
) {
    val isValid: Boolean get() = category == NotificationCategory.deliverNews || category == NotificationCategory.cancelNews
}
