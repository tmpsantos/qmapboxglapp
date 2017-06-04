import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: dateAndTime

    property var currentDate: new Date();

    RowLayout {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        CustomLabel {
            font.capitalization: Font.AllUppercase
            text: Qt.formatDateTime(dateAndTime.currentDate, "MMMM")
        }

        CustomLabel {
            text: Qt.formatDateTime(dateAndTime.currentDate, "d")
        }

        CustomLabel {
            text: "|"
        }

        CustomLabel {
            font.capitalization: Font.AllUppercase
            text: Qt.formatDateTime(dateAndTime.currentDate, "HH:MM")
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true

        onTriggered: {
            dateAndTime.currentDate = new Date();
        }
    }
}
