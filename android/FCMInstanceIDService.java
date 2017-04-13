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

package org.kde.ruqola.notification;

import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;

import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.FirebaseInstanceIdService;

public class FCMInstanceIDService extends FirebaseInstanceIdService {
   private static final String TAG = MyFirebaseInstanceIDService.class.getSimpleName();

   @Override
   public void onTokenRefresh() {
       super.onTokenRefresh();
       String refreshedToken = FirebaseInstanceId.getInstance().getToken();

       // Saving reg id to shared preferences
       storeRegIdInPref(refreshedToken);

       // sending reg id to your server
       sendRegistrationToServer(refreshedToken);

       // Notify UI that registration has completed, so the progress indicator can be hidden
       Intent registrationComplete = new Intent(Config.REGISTRATION_COMPLETE);
       registrationComplete.putExtra("token", refreshedToken);
       LocalBroadcastManager.getInstance(this).sendBroadcast(registrationComplete);
   }

   private void sendRegistrationToServer(final String token) {
       // sending gcm token to server
       Log.e(TAG, "sendRegistrationToServer: " + token);
   }

   private void storeRegIdInPref(String token) {
       // to store in local shared preferences
   }
}
