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

#ifndef NOTIFICATION_H
#define NOTIFICATION_H

#include <QSystemTrayIcon>
#include <QAction>
#include <QMenu>

class Notification: public QSystemTrayIcon
{
    Q_OBJECT
    Q_PROPERTY(bool windowVisible READ windowVisible WRITE setWindowVisible NOTIFY windowVisibleChanged)
    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)

public:

    void setWindowVisible(bool val);
    bool windowVisible() const;

    void setMessage(const QString &message);
    QString message() const;

    Notification();

signals:
    void windowVisibleChanged();
    void messageChanged();

private slots:
    void updateDesktopNotification();

private:
    void createActions();
    void createTrayIcon();

    QAction *m_quitAction;
    QMenu *m_trayIconMenu;
    bool m_windowVisible;

    //Notification message
    QString m_message;

};

#endif // NOTIFICATION_H
