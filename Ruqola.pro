TEMPLATE = app

QT += widgets gui core qml quick websockets
android: QT += androidextras

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += src/messagemodel.h src/roommodel.h src/ddpclient.h src/rocketchatbackend.h \
    src/notification.h \
    src/ruqola.h
SOURCES += main.cpp src/messagemodel.cpp src/roommodel.cpp src/ddpclient.cpp src/rocketchatbackend.cpp \
    src/notification.cpp \
    src/ruqola.cpp

RESOURCES += qml.qrc

CONFIG += c++11

# Additional import path used to resolve QML modules in Qt Creator's code model
# QML_IMPORT_PATH = 

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/google-services.json \
    android/FCMInstanceIDService.java \
    android/Config.java \
    android/FCMMessagingService.java \
    android/SubscribeToTopic.java \
    android/gradle/wrapper/gradle-wrapper.properties~ \
    android/res/drawable-ldpi/icon.png \
    android/gradlew \
    android/gradlew.bat
