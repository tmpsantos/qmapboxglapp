TARGET = qmapboxapp
TEMPLATE = app

QT += qml network quick positioning location sql widgets

CONFIG += c++14

ios|android {
    QT -= widgets
}

SOURCES += \
    qmapboxapp.cpp \
    qcheapruler.cpp

HEADERS += \
    qcheapruler.hpp

INCLUDEPATH += \
    include

OTHER_FILES += \
    qmapboxapp.qml

RESOURCES += \
    qmapboxapp.qrc
