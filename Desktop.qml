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


// Skeleton from https://github.com/achipa/outqross_blog.git
// Almost everything has been re-adapted

import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0

import KDE.Ruqola.UserData 1.0
import KDE.Ruqola.DDPClient 1.0
import KDE.Ruqola.Notification 1.0


// import "Log.js" as Log
// import "Data.js" as Data

ApplicationWindow {
    property int margin: 11
    property string statusText
    
    property string lightGreen: "#6ab141";
    property string darkGreen: "#00613a";
    
    property string selectedRoomID: "";
    
    id: appid
    title: qsTr("Ruqola")
    width: 800
    height: 600
    visible: true

    Shortcut {
        sequence: StandardKey.Quit
        context: Qt.ApplicationShortcut
        onActivated: Qt.quit()
    }

    Login {
        id: loginTab
        visible: (UserData.loginStatus == DDPClient.LoginFailed || UserData.loginStatus == DDPClient.LoggedOut)
//        visible: (UserData.loginStatus != DDPClient.LoggedIn)
        anchors.fill:parent
        z: 10
        serverURL: UserData.serverURL
        username: UserData.userName
        onAccepted: {
            UserData.password = loginTab.password;
            UserData.userName = loginTab.username;
            UserData.serverURL = loginTab.serverURL;
            UserData.tryLogin();
            console.log("after trylogin()");
        }        
    }
    
    BusyIndicator {
        id: busy
        anchors.centerIn: parent
        visible: UserData.loginStatus == DDPClient.LoggingIn
    }

    Item {
        id: mainWidget
        anchors.fill: parent
        visible: !loginTab.visible

        Rectangle {
            id: userBox
            anchors.top: parent.top
            width: parent.width
            anchors.left: parent.left
            anchors.right: roomsList.right
            height: 40
            color: darkGreen
            Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                anchors.rightMargin: 10
                anchors.fill: parent
                font.pointSize: 12
                color: "white"
                text: "Hello, " + UserData.userName
            }
            
        }
            
        RoomsView {
            anchors.top: userBox.bottom
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 0            
            width: 200
            height: appid.height

            id: roomsList
            
            model: UserData.roomModel()

            visible: parent.visible
            
            selectedRoomID: appid.selectedRoomID;
            
            onRoomSelected: {
                if (roomID == selectedRoomID) {
                    return;
                }
                console.log("Choosing room", roomID);
                appid.selectedRoomID = roomID;
                activeChat.model = UserData.getModelForRoom(roomID)
                topicWidget.selectedRoom = UserData.getRoom(roomID)
            }
            
            onCountChanged: {
//                 console.log("We have", roomsList.count, "rooms")
            }
            
            LinearGradient {
                id: greenGradient
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(roomsList.width, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#6ab141" }
                    GradientStop { position: 1.0; color: "#00613a" }
                }
                z: -1;
                
            }
        }
        
        
        Item {
            anchors.right: parent.right
            anchors.left: roomsList.right
            anchors.top: parent.top
            anchors.bottom: messageLine.top
            
//             Item {
//                 anchors.fill: parent
//                 id: greeter
//                 visible: false
// //                 visible: selectedRoomID.empty
//                 Text {
//                     text: "Welcome to Ruqola!";
//                 }
//             }
            Rectangle {
                id: topicWidget
                color: "#fff"
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                height: nameLabel.height + topicLabel.height
                property var selectedRoom;
                
                Text {
                    id: nameLabel
//                    console.log("parent" + parent);
                    text: "#" + parent.selectedRoom.name
                    font.pointSize: 18
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                    height: 40
                   // height: font.pixelSize + 10

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    
                }
                
                Text {
                    id: topicLabel
                    text: topicWidget.selectedRoom.topic
                    
                    anchors.top: nameLabel.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    
                    horizontalAlignment: Text.AlignHCenter
                    
                    height: font.pixelSize + 10
                }

            }
            
            ScrollView {
                
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: topicWidget.bottom
                anchors.bottom: parent.bottom
                
                verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
//                 visible: parent.visible && (UserData.loginStatus != DDPClient.LoggingIn)
//                visible: !greeter.visible

         
                ListView {
                    id: activeChat
//                     model: UserData.getModelForRoom(selectedRoomID)

                    onCountChanged: {
    //                     console.log("changed")
    //                     var newIndex = count - 1 // last index
    //                     positionViewAtEnd()
                        positionViewAtIndex(count - 1, ListView.Beginning)

    //                     currentIndex = newIndex
                    }
    //                 Component.onCompleted: positionViewAtEnd()
                    Component.onCompleted: positionViewAtIndex(count - 1, ListView.Beginning)


    //                 onSelectedRoomIDChanged: { console.log("CHANGED"); activeChat.positionViewAtEnd(); }

    //                 model: myModel
                    anchors.fill:parent
                    visible : count > 0
                    
                    
                    z: -1
                    
        //             ScrollBar.vertical: ScrollBar { }
                    
                    delegate: Message {
                                i_messageText: messageText
                                i_username: username
                                i_systemMessage: systemMessage
                                i_systemMessageType: type
                                width: parent.width
                            }
                }
            }
        }
        TextField {
            id: messageLine
            anchors.right: parent.right
            anchors.left: roomsList.right
            anchors.bottom: parent.bottom
            placeholderText: if (UserData.loginStatus != DDPClient.LoggedIn || (selectedRoomID=="")){
                                 qsTr("Please Select a room")
                             }
                             else{
                                 qsTr("Enter message")
                             }
            height: 2.7*font.pixelSize

            onAccepted: {
                if (text != "" && UserData.loginStatus == DDPClient.LoggedIn && !(selectedRoomID=="")) {
                    UserData.sendMessage(selectedRoomID, text);
                    text = "";
                }
            }
        }
    }//mainWidget Item
    
    Rectangle {
        z: -10
        anchors.fill: parent
        color: "white"
    }
    
    onClosing: {
        console.log("Minimizing to systray...");
        hide();
    }
    
    function toggleShow() {

        if (visible) {
            hide();
        } else {
            show();
            raise();
            requestActivate();
        }
    }
    Component.onCompleted: {

//         roomsList.model = UserData.roomModel();

//        timer.start();
//        timer.fire();
    }

/*    
    Timer {
        id: timer
        interval: 1000
        onTriggered: {
//             console.log("FIRE");
            switch (UserData.loginStatus) {
                case UserData.NotConnected:
                    statusText = qsTr("Not connected.");
                    break;
                case UserData.LoggedIn:
                        statusText = qsTr("Connected to " + UserData.serverURL);
                        break;
                    
            }
        }
        repeat: true
    }*/

//    onStatusTextChanged: timer.restart();


}//appid ApplicationWindow
