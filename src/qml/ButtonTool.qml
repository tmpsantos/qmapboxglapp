import QtQuick 2.0
import QtQuick.Controls 2.0

Button {
    id: control

    checkable: true

    property bool check: control.checked
    property alias buttonText: control.text

    contentItem: Item {
        Text {
            anchors.centerIn: parent
            text: control.text
            color: "#ffffff"
            font.pixelSize: 18
        }
    }

    background: Image {
        source: checked ? "qrc:auto-knob-down.png" : "qrc:auto-knob-up.png"
    }
}
