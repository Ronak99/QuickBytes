package com.quickbytes.quickbytes_app.Activity

import android.content.Intent
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import com.quickbytes.quickbytes_app.Constants.kNotificationTypeNews
import com.quickbytes.quickbytes_app.MainActivity
import com.quickbytes.quickbytes_app.R
import com.quickbytes.quickbytes_app.Services.NavigationService


class NavigationActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        val type = intent.getStringExtra("type")
        val data = intent.getStringExtra("data")


        when (type) {
            kNotificationTypeNews -> {
                NavigationService().onNewsNotificationTap(data)
            }
        }

        val intent = Intent(this, MainActivity::class.java)
        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        startActivity(intent)
        finish()
    }
}