import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: statusBar

    height: 100

    Image {
        anchors.fill: parent

        source: "qrc:simple-bottom-background.png"
    }

    Row {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        spacing: 16

        Image {
            source: "qrc:bluetooth.png"
        }

        Image {
            source: "qrc:wifi-signal-strength.png"
        }

        Image {
            source: "qrc:4g-signal-strength.png"
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width / 4
        spacing: 10

        Loader {
            source: "qrc:DateAndTime.qml"
        }
    }

    Image {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        scale: 0.5

        source: "qrc:john.png"
    }
}
