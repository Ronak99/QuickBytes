package com.quickbytes.quickbytes_app.Services

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.pm.PackageManager
import android.content.res.Configuration
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.os.Build
import android.util.Log
import android.widget.RemoteViews
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.quickbytes.quickbytes_app.Constants.kChannelId
import com.quickbytes.quickbytes_app.Constants.kChannelName
import com.quickbytes.quickbytes_app.Models.AppNotification
import com.quickbytes.quickbytes_app.R
import io.flutter.app.FlutterMultiDexApplication

class NotificationService(val context: Context) {
    private val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

    private val notificationTitleColorDark = context.getColor(R.color.collapsed_notification_title_dark)
    private val notificationTitleColorLight = context.getColor(R.color.collapsed_notification_title_light)

    private val notificationTitleColor: Int = if (isDarkTheme(context)) {
        notificationTitleColorDark
    } else {
        notificationTitleColorLight
    }


    private fun createNotificationChannel(){
        val channel =  NotificationChannel(
            kChannelId,
            kChannelName,
            NotificationManager.IMPORTANCE_HIGH,
        )

        notificationManager.createNotificationChannel(channel)
    }

    private fun isDarkTheme(context:Context): Boolean {
        val currentNightMode: Int =
            context.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK
        return currentNightMode == Configuration.UI_MODE_NIGHT_YES
    }

    fun dispatchNotification(appNotification: AppNotification){
        createNotificationChannel()

        val notificationHasBeenDelivered = FlutterMultiDexApplication.notificationIdentifier.hasBeenDelivered(appNotification.article.id)
        if(notificationHasBeenDelivered) return;

        Glide.with(context)
            .asBitmap()
            .load(appNotification.article.image)
            .into(object : CustomTarget<Bitmap>() {
                override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
                    val expandedNotificationView = RemoteViews(context.packageName, R.layout.expanded_notification_view)
                    expandedNotificationView.setImageViewBitmap(R.id.notification_image, resource)
                    expandedNotificationView.setTextViewText(R.id.expanded_notification_title, appNotification.article.title)

                    val collapsedNotificationView = RemoteViews(context.packageName, R.layout.collapsed_notification_view)
                    collapsedNotificationView.setTextViewText(R.id.collapsed_notification_title, appNotification.article.title)
                    collapsedNotificationView.setTextColor(R.id.collapsed_notification_title, notificationTitleColor)

                    val notification = NotificationCompat.Builder(context, kChannelId)
                        .setSmallIcon(androidx.core.R.drawable.notification_bg)
                        .setCustomBigContentView(expandedNotificationView)
                        .setContent(collapsedNotificationView)
                        .build()

                    // Show the notification
                    if (ActivityCompat.checkSelfPermission(
                            context,
                            Manifest.permission.POST_NOTIFICATIONS
                        ) != PackageManager.PERMISSION_GRANTED
                    ) {
                        // TODO: Consider calling
                        //    ActivityCompat#requestPermissions
                        return
                    }


                    NotificationManagerCompat.from(context).notify(appNotification.id, notification)
                    FlutterMultiDexApplication.notificationIdentifier.markAsDelivered(appNotification.article.id);
                }

                override fun onLoadCleared(placeholder: Drawable?) {
                    // Handle any cleanup here if needed
                }
            })
    }

    fun cancelNotification(appNotification: AppNotification) {
        NotificationManagerCompat.from(context).cancel(appNotification.id)
    }
}