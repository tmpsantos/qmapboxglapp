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

        TumblerTool {
            id: tumblerLeft

            index: 10
            Layout.fillWidth: true
            anchors.verticalCenter: parent.verticalCenter
        }

        TumblerTool {
            id: tumblerRight

            index: 5
            Layout.fillWidth: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
