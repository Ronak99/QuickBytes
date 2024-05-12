package com.quickbytes.quickbytes_app.Services

import android.util.Log
import io.flutter.app.FlutterMultiDexApplication

class NavigationService {
    private val TAG = "NavigationService"

    fun onNewsNotificationTap(data:String?){
        if(data != null){
            FlutterMultiDexApplication.sendDataToFlutter(data)
        }else{
            Log.d(TAG, "Data was empty")
        }
    }

}