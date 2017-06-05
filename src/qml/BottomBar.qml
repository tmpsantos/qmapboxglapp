import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: bottomBar

    height: 270

    Image {
        anchors.fill: parent

        source: "qrc:simple-bottom-background.png"
    }

    RowLayout {
        anchors.fill: parent

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
}
