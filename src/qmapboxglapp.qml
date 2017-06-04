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

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            Label {
                Layout.fillWidth: true

                text: window.title
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            ComboBox {
                Layout.minimumWidth: 200

                currentIndex: 0

                model: ListModel {
                    id: styleModel
                }

                onActivated: {
                    map.activeMapType = map.supportedMapTypes[index];
                }
            }
        }
    }

    Loader {
        anchors.fill: parent

        source: "qrc:MapWindow.qml"
    }
}
