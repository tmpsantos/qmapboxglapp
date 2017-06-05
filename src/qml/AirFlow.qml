import QtQuick 2.0
import QtQuick.Controls 2.0

Button {
    id: control

    checkable: true

    background: Image {
        source: checked ? "qrc:air-flow-down.png" : "qrc:air-flow-up.png"
    }
}
