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


#include <QApplication>
#include <QtQml>

#include "src/roommodel.h"
#include "src/rocketchatbackend.h"
#include "src/messagemodel.h"
#include "src/ruqola.h"
#include "src/ddpclient.h"
#include "src/notification.h"

#include <QDebug>
#include <QtCore/QJsonDocument>
#include <QtCore>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/systray.png"));
    
    QCoreApplication::setOrganizationName("KDE");
    QCoreApplication::setOrganizationDomain("kde.org");
    QCoreApplication::setApplicationName("Ruqola");
    
    qmlRegisterSingletonType<Ruqola>("KDE.Ruqola.Ruqola", 1, 0, "Ruqola", ruqola_singletontype_provider);
    qmlRegisterType<MessageModel>("KDE.Ruqola.MessageModel", 1, 0, "MessageModel");
    qmlRegisterType<DDPClient>("KDE.Ruqola.DDPClient", 1, 0, "DDPClient");
    qmlRegisterType<RoomModel>("KDE.Ruqola.RoomModel", 1, 0, "RoomModel");
    qmlRegisterType<RoomWrapper>("KDE.Ruqola.RoomWrapper", 1, 0, "RoomWrapper");
    qmlRegisterType<Notification>("KDE.Ruqola.Notification", 1, 0, "Notification");

    RocketChatBackend c;
    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
