/*
 * <one line to give the program's name and a brief idea of what it does.>
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

#include "ruqola.h"
#include "notification.h"

#include <QtAndroidExtras/QAndroidJniObject>


void Notification::setMessage(const QString &message)
{
    if (m_message != message){
        m_message = message;
        emit messageChanged();
    }
}

QString Notification::message() const
{
    return m_message;
}

void Notification::updateAndroidNotification()
{
    //Link cpp function to java function
    //params- Java className, MethodName, (Arguments)ReturnType, JNIObject
    QAndroidJniObject javaNotification = QAndroidJniObject::fromString(m_message);
    QAndroidJniObject::callStaticMethod<void>("android/FCMMessagingService/NotificationClient",
                                       "notify",
                                       "(Ljava/lang/String;)V",
                                       javaNotification.object<jstring>());
}

Notification::Notification(){
     connect(this, &Notification::messageChanged, this, &Notification::updateAndroidNotification);
}


/*
 *
 *  Desktop Application code
 *
 *
#include <QAction>
#include <QMenu>
#include <QMessageBox>
#include <QWindow>

//create actions in Menu
void Notification::createActions(){
    qDebug() << "create action called";
   m_quitAction = new QAction(tr("&Quit"), this);
   connect(m_quitAction, &QAction::triggered, qApp, &QCoreApplication::quit);
}

//create systrayIcon
void Notification::createTrayIcon(){

    qDebug() << "create trayIcon called";
    if (!QSystemTrayIcon::isSystemTrayAvailable()) {
        QMessageBox::critical(0, QObject::tr("Systray"), QObject::tr("Cannot detect SystemTray on this system."));
        return;
    }
    m_trayIconMenu = new QMenu();
    m_trayIconMenu->addAction(m_quitAction);
    m_trayIconMenu->addSeparator();
    this->setContextMenu(m_trayIconMenu);
    this->setToolTip("Ruqola");
    this->setIcon(QIcon(":/systray.png"));
    this->setVisible(true);

}

Notification::Notification(): m_windowClosed(false){
    createActions();
    createTrayIcon();
}

*/

