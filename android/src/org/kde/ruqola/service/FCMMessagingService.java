/* <one line to give the program's name and a brief idea of what it does.>
* Copyright 2016  Riccardo Iaconelli <riccardo@kde.org>
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation; either version 2 of
* the License or (at your option) version 3 or any later version
* accepted by the membership of KDE e.V. (or its successor approved
* by the membership of KDE e.V.), which shall act as a proxy
* defined in Section 14 of version 3 of the license.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

package org.kde.ruqola.service;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.support.v4.content.LocalBroadcastManager;
import android.text.TextUtils;
import android.util.Log;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import org.json.JSONException;
import org.json.JSONObject;

import org.kde.ruqola.app.Config;
import org.kde.ruqola.util.NotificationUtil;


public class FCMMessagingService extends FirebaseMessagingService {

        private static final String TAG = FCMMessagingService.class.getSimpleName();

        private NotificationUtil notificationUtil;

        @Override
        public void onMessageReceived(RemoteMessage remoteMessage) {
            Log.e(TAG, "From: " + remoteMessage.getFrom());

            if (remoteMessage == null)
                return;

            // Check if message contains a notification payload.
            if (remoteMessage.getNotification() != null) {
                Log.e(TAG, "Notification Body: " + remoteMessage.getNotification().getBody());
                handleNotification(remoteMessage.getNotification().getBody());
            }

            // Check if message contains a data payload.
            if (remoteMessage.getData().size() > 0) {
                Log.e(TAG, "Data Payload: " + remoteMessage.getData().toString());

                try {
                    JSONObject json = new JSONObject(remoteMessage.getData().toString());
                    handleDataMessage(json);
                } catch (Exception e) {
                    Log.e(TAG, "Exception: " + e.getMessage());
                }
            }
        }

        private void handleNotification(String message) {
            if (!NotificationUtil.isAppInBackground(getApplicationContext())) {
                // app is in foreground, broadcast the push message
                Intent pushNotification = new Intent(Config.PUSH_NOTIFICATION);
                pushNotification.putExtra("message", message);
                LocalBroadcastManager.getInstance(this).sendBroadcast(pushNotification);

                // play notification sound
                NotificationUtil notificationUtil = new NotificationUtil(getApplicationContext());
                notificationUtil.playNotificationSound();
            }else{
                // If the app is in background, firebase itself handles the notification
            }
        }

        private void handleDataMessage(JSONObject json) {
            Log.e(TAG, "push json: " + json.toString());
        }

        //Showing notification with text only
        private void showNotificationMessage(Context context, String title, String message, String timeStamp, Intent intent) {
            notificationUtil = new NotificationUtil(context);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
            notificationUtil.showNotificationMessage(title, message, timeStamp, intent);
        }

        //Showing notification with text and image
        private void showNotificationMessageWithBigImage(Context context, String title, String message, String timeStamp, Intent intent, String imageUrl) {
            notificationUtil = new NotificationUtil(context);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
            notificationUtil.showNotificationMessage(title, message, timeStamp, intent, imageUrl);
        }

}//FCMMessagingService Class

