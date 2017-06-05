import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Item {
    height: parent.height
    width: 150

    property alias index: tumbler.currentIndex
    property real scaleFactor: 1.5

    Tumbler {
        id: tumbler

        z: 0
        model: 8
        anchors.fill: parent
        visibleItemCount: 3

        contentItem: ListView {
            anchors.fill: parent
            model: tumbler.model
            delegate: tumbler.delegate
            snapMode: ListView.SnapToItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: height / 2 - (height / tumbler.visibleItemCount / 2)
            preferredHighlightEnd: height / 2  + (height / tumbler.visibleItemCount / 2)
            clip: true
        }

        delegate: CustomLabel {
            text: ("%1 °").arg(modelData + 18)
            font.pixelSize: 38
            scale: ListView.isCurrentItem ? scaleFactor : 1
            horizontalAlignment: Text.AlignHCenter
            opacity: 0.4 + Math.max(0, 1 - Math.abs(Tumbler.displacement)) * 0.6
            color: "#ffffff"

            Behavior on scale {
                NumberAnimation { duration: 200 }
            }
        }
    }
}
