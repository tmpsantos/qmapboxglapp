TARGET = qmapboxglapp
TEMPLATE = app

QT += qml network quick positioning location sql widgets

CONFIG += c++14

ios|android {
    QT -= widgets
}

SOURCES += \
    src/qmapboxglapp.cpp \
    src/qcheapruler.cpp

HEADERS += \
    src/qcheapruler.hpp

INCLUDEPATH += \
    include

OTHER_FILES += \
    src/qmapboxlgapp.qml

RESOURCES += \
    assets/assets.qrc \
    src/qmapboxglapp.qrc
