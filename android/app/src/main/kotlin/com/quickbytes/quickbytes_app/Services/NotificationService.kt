package com.quickbytes.quickbytes_app.Services

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.res.Configuration
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.widget.RemoteViews
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.quickbytes.quickbytes_app.Activity.NavigationActivity
import com.quickbytes.quickbytes_app.Constants.kChannelId
import com.quickbytes.quickbytes_app.Constants.kChannelName
import com.quickbytes.quickbytes_app.Constants.kNotificationTypeNews
import com.quickbytes.quickbytes_app.Models.NewsNotification
import com.quickbytes.quickbytes_app.R
import io.flutter.app.FlutterMultiDexApplication
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

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

    fun dispatchNotification(newsNotification: NewsNotification){
        createNotificationChannel()

        val notificationHasBeenDelivered = FlutterMultiDexApplication.notificationIdentifier.hasBeenDelivered(newsNotification.article.id)
        if(notificationHasBeenDelivered) return;

        Glide.with(context)
            .asBitmap()
            .load(newsNotification.article.image)
            .into(object : CustomTarget<Bitmap>() {
                override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
                    prepareAndDispatch(context, resource, newsNotification)
                }

                override fun onLoadCleared(placeholder: Drawable?) {
                    // Handle any cleanup here if needed
                }
            })
    }

    private fun prepareAndDispatch(context: Context, resource:Bitmap, newsNotification: NewsNotification) {
        // Prepare intent
        val navigationActivityIntent = Intent(context, NavigationActivity::class.java)
        navigationActivityIntent.putExtra("type", kNotificationTypeNews)
        navigationActivityIntent.putExtra("data", Json.encodeToString<NewsNotification>(newsNotification))

        // Prepare PendingIntent
        val intentFlags = PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        val pendingIntent = PendingIntent.getActivity(context, newsNotification.id, navigationActivityIntent, intentFlags)

        // Prepare expanded view
        val expandedNotificationView = RemoteViews(context.packageName, R.layout.expanded_notification_view)
        expandedNotificationView.setImageViewBitmap(R.id.notification_image, resource)
        expandedNotificationView.setTextViewText(R.id.expanded_notification_title, newsNotification.article.title)

        // Prepare collapsed view
        val collapsedNotificationView = RemoteViews(context.packageName, R.layout.collapsed_notification_view)
        collapsedNotificationView.setTextViewText(R.id.collapsed_notification_title, newsNotification.article.title)
        collapsedNotificationView.setTextColor(R.id.collapsed_notification_title, notificationTitleColor)

        // Prepare notification
        val notification = NotificationCompat.Builder(context, kChannelId)
            .setSmallIcon(R.mipmap.notification_icon)
            .setCustomBigContentView(expandedNotificationView)
            .setContent(collapsedNotificationView)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
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

        NotificationManagerCompat.from(context).notify(newsNotification.id, notification)
        FlutterMultiDexApplication.notificationIdentifier.markAsDelivered(newsNotification.article.id);
    }

    fun cancelNotification(newsNotification: NewsNotification) {
        NotificationManagerCompat.from(context).cancel(newsNotification.id)
    }
}