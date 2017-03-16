TARGET = qmapboxapp
TEMPLATE = app

QT += qml network quick positioning location sql widgets

ios|android {
    QT -= widgets
}

SOURCES += \
    qmapboxapp.cpp

RESOURCES += \
    qmapboxapp.qrc
