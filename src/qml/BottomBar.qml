import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: bottomBar

    property alias traffic: trafficButton.checked
    property alias night: nightButton.checked

    height: 270

    Image {
        anchors.fill: parent

        source: "qrc:simple-bottom-background.png"
    }

    RowLayout {
        anchors.fill: parent

        TumblerTool {
            id: tumblerLeft

            anchors.verticalCenter: parent.verticalCenter

            index: 10
            Layout.fillWidth: true
        }

        ButtonTool {
            id: trafficButton

            anchors.verticalCenter: parent.verticalCenter

            text: "TRAFFIC"
            checked: true
        }

        AirFlow {
            anchors.verticalCenter: parent.verticalCenter
        }

        ButtonTool {
            id: nightButton

            anchors.verticalCenter: parent.verticalCenter

            text: "NIGHT"
            checked: true
        }

        TumblerTool {
            id: tumblerRight

            anchors.verticalCenter: parent.verticalCenter

            index: 5
            Layout.fillWidth: true
        }
    }
}
