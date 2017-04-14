TEMPLATE = app

QT += widgets gui core qml quick websockets
android: QT+= androidextras

HEADERS += src/messagemodel.h src/roommodel.h src/ddpclient.h src/ruqola.h src/rocketchatbackend.h \
    src/notification.h
SOURCES += main.cpp src/messagemodel.cpp src/roommodel.cpp src/ddpclient.cpp src/ruqola.cpp src/rocketchatbackend.cpp \
    src/notification.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
# QML_IMPORT_PATH = 

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/google-services.json \
    android/FCMInstanceIDService.java \
    android/FCMMessagingService.java \
    android/SubscribeToTopic.java \
    android/org.kde.ruqola/service/FCMInstanceIDService.java \
    android/android.iml \
    android/res/drawable-ldpi/icon.png \
    android/org.kde.ruqola/service/FCMMessagingService.java \
    android/org.kde.ruqola/util/SubscribeToTopic.java \
    android/gradle.properties \
    android/local.properties \
    android/org.kde.ruqola/app/Config.java \
    android/org.kde.ruqola/util/NotificationUtils.java \
    android/res/raw/notification.mp3 \
    android/MainActivity.java \
    android/org.kde.ruqola/activity/MainActivity.java

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
