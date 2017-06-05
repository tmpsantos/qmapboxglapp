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

            anchors.verticalCenter: parent.verticalCenter

            index: 10
            Layout.fillWidth: true

            onIndexChanged: {
                if (syncButton.checked === true)
                    tumblerRight.index = tumblerLeft.index
            }
        }

        ButtonTool {
            anchors.verticalCenter: parent.verticalCenter

            text: "AUTO"
        }

        AirFlow {
            anchors.verticalCenter: parent.verticalCenter
        }

        ButtonTool {
            id: syncButton

            anchors.verticalCenter: parent.verticalCenter

            text: "SYNC"

            onCheckedChanged: {
                if (checked === true)
                    tumblerRight.index = tumblerLeft.index
            }
        }

        TumblerTool {
            id: tumblerRight

            anchors.verticalCenter: parent.verticalCenter

            index: 5
            Layout.fillWidth: true

            onIndexChanged: {
                if (syncButton.checked === true)
                    tumblerLeft.index = tumblerRight.index
            }
        }
    }
}
