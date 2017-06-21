TARGET = qmapboxglapp
TEMPLATE = app

QT += qml network quick positioning location sql widgets

ios|android {
    QT -= widgets
}

SOURCES += \
    qmapboxglapp.cpp

OTHER_FILES += \
    qmapboxglapp.qml

RESOURCES += \
    qmapboxglapp.qrc
