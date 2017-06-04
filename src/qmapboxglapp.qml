import QtGraphicalEffects 1.0
import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

import com.mapbox.cheap_ruler 1.0

ApplicationWindow {
    id: window

    // Km/h
    property var carSpeed: 50
    property var navigating: true

    title: "Mapbox GL for Qt 5.9"
    width: 1024
    height: 768
    visible: true

    Loader {
        anchors.left: parent.left
        anchors.right: parent.right

        z: 1

        source: "qrc:StatusBar.qml"
    }

    Loader {
        anchors.fill: parent
        z: 0

        source: "qrc:MapWindow.qml"
    }

    Loader {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        z: 1

        source: "qrc:StatusBar.qml"
    }
}
