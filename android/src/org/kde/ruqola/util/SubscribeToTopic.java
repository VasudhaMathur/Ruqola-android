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

package org.kde.ruqola.util;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.content.LocalBroadcastManager;
import android.text.TextUtils;
import android.util.Log;

import com.google.firebase.messaging.FirebaseMessaging;



public class SubscribeToTopic {

    public void subscribeTopic(String topic) {
            // gcm successfully registered
            // now subscribe to topic to receive app wide notifications
            FirebaseMessaging.getInstance().subscribeToTopic(topic);
    }

}
