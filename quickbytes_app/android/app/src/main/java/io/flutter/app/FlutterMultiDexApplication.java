// Generated file.
//
// If you wish to remove Flutter's multidex support, delete this entire file.
//
// Modifications to this file should be done in a copy under a different name
// as this file may be regenerated.

package io.flutter.app;

import android.app.Application;
import android.content.Context;
import androidx.annotation.CallSuper;
import androidx.multidex.MultiDex;

import com.quickbytes.quickbytes_app.Services.NotificationService;
import com.quickbytes.quickbytes_app.Utils.NotificationIdentifier;

import java.util.ArrayList;

import io.flutter.plugin.common.EventChannel;

/**
 * Extension of {@link android.app.Application}, adding multidex support.
 */
public class FlutterMultiDexApplication extends Application {

  static public NotificationIdentifier notificationIdentifier = new NotificationIdentifier();
  static private EventChannel.EventSink eventSink;

  static public void initializeEventSink(EventChannel.EventSink events) {
    eventSink = events;
  }

  /*
        When app is launched, it looks for any pending notifications that users are required to be routed to
        This pending notification list is only utilised by the notifications shown natively.

        Native system adds to pending notification list when notification is interacted with.
        Flutter clears the pending notification list when notification has served it's purpose.
    */
  public static ArrayList<String> pendingNotificationList = new ArrayList<>();

  static public void sendDataToFlutter(String o) {
    addToPendingNotificationList(o);
    if(eventSink != null){
      eventSink.success(o);
    }
  }

  static private void addToPendingNotificationList(String notificationData){
    pendingNotificationList.add(notificationData);
  }

  static public void resetPendingNotificationList(){
    pendingNotificationList.clear();
  }

  @Override
  @CallSuper
  protected void attachBaseContext(Context base) {
    super.attachBaseContext(base);
    MultiDex.install(this);
  }
}
