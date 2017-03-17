import QtGraphicalEffects 1.0
import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: window

    title: "Mapbox GL for Qt 5.9"
    width: 1024
    height: 768
    visible: true

    Rectangle {
        anchors.fill: parent
    }

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

    Drawer {
        id: drawer

        y: header.height
        width: window.width * 0.4
        height: window.height - header.height

        ColumnLayout {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10

            GroupBox {
                anchors.left: parent.left
                anchors.right: parent.right
                title: "Flip:"

                Slider {
                    id: flipSlider

                    anchors.left: parent.left
                    anchors.right: parent.right
                    to: 180
                }
            }

            GroupBox {
                anchors.left: parent.left
                anchors.right: parent.right
                title: "Items:"

                ButtonGroup {
                    id: sourceGroup

                    buttons: column2.children
                }

                ColumnLayout {
                    id: column2

                    RadioButton {
                        text: "JSON 1"
                        checked: true
                        onClicked: {
                            map.clearMapItems();
                            source.data = ":source1.geojson"
                        }
                    }

                    RadioButton {
                        text: "JSON 2"
                        onClicked: {
                            map.clearMapItems();
                            source.data = ":source2.geojson"
                        }
                    }

                    RadioButton {
                        text: "JSON Inline"
                        onClicked: {
                            map.clearMapItems();
                            source.data = '{ "type": "FeatureCollection", "features": \
                                [{ "type": "Feature", "properties": {}, "geometry": { \
                                "type": "LineString", "coordinates": [[ 24.934938848018646, \
                                60.16830257086771 ], [ 24.943315386772156, 60.16227776476442 ]]}}]}'
                        }
                    }

                    RadioButton {
                        text: "Circle"
                        onClicked: {
                            map.clearMapItems();

                            var circle = Qt.createQmlObject('import QtLocation 5.3; MapCircle {}', map)
                            circle.center = QtPositioning.coordinate(60.170448, 24.942046) // Helsinki
                            circle.radius = 2000.0
                            circle.border.width = 3

                            map.addMapItem(circle)
                        }
                    }

                    RadioButton {
                        text: "Polyline"
                        onClicked: {
                            map.clearMapItems();

                            var poly = Qt.createQmlObject('import QtLocation 5.3; MapPolyline {}', map)
                            poly.addCoordinate(QtPositioning.coordinate(60.210448, 24.912046))
                            poly.addCoordinate(QtPositioning.coordinate(60.170448, 24.942046))
                            poly.line.width = 3
                            poly.line.color = "red"

                            map.addMapItem(poly)
                        }
                    }

                    RadioButton {
                        Image {
                            id: icon

                            visible: false
                            opacity: .75

                            sourceSize.width: 80
                            sourceSize.height: 80

                            source: "icon.png"
                        }

                        text: "QuickItem"
                        onClicked: {
                            map.clearMapItems();

                            var item = Qt.createQmlObject('import QtLocation 5.3; MapQuickItem {}', map)
                            item.coordinate = QtPositioning.coordinate(60.170448, 24.942046) // Helsinki
                            item.sourceItem = icon
                            item.anchorPoint.x = icon.width / 2
                            item.anchorPoint.y = icon.height / 2

                            icon.visible = true

                            map.addMapItem(item)
                        }
                    }
                }
            }
        }
    }

    Flipable {
        id: flipable
        anchors.fill: parent

        transform: Rotation {
            origin.x: flipable.width / 2
            origin.y: flipable.height / 2
            axis.x: 0; axis.y: 1; axis.z: 0
            angle: flipSlider.value
        }

        front: Map {
            id: map
            anchors.fill: parent

            plugin: Plugin { name: "mapboxgl" }

            center: QtPositioning.coordinate(60.170448, 24.942046) // Helsinki
            zoomLevel: 12.25
            minimumZoomLevel: 0
            maximumZoomLevel: 20

            MapParameter {
                type: "bogus"

                property var test1: "foobar"
                property var test2: 123
            }

            MapParameter {
                id: source
                type: "source"

                property var name: "routeSource"
                property var sourceType: "geojson"
                property var data: ":source1.geojson"
            }

            MapParameter {
                type: "layer"

                property var name: "routeCase"
                property var layerType: "line"
                property var source: "routeSource"
            }

            MapParameter {
                type: "paint"

                property var layer: "routeCase"
                property var lineColor: "white"
                property var lineWidth: 20.0
            }

            MapParameter {
                type: "layout"

                property var layer: "routeCase"
                property var lineJoin: "round"
                property var lineCap: lineJoin
                property var visibility: sourceGroup.checkedButton.text.startsWith("JSON") ? "visible" : "none"
            }

            MapParameter {
                type: "layer"

                property var name: "route"
                property var layerType: "line"
                property var source: "routeSource"
            }

            MapParameter {
                id: linePaint
                type: "paint"

                property var layer: "route"
                property var lineColor: "blue"
                property var lineWidth: 8.0
            }

            MapParameter {
                type: "layout"

                property var layer: "route"
                property var lineJoin: "round"
                property var lineCap: "round"
                property var visibility: sourceGroup.checkedButton.text.startsWith("JSON") ? "visible" : "none"
            }

            MapParameter {
                type: "image"

                property var name: "label-arrow"
                property var sprite: ":label-arrow.png"
            }

            MapParameter {
                type: "image"

                property var name: "label-background"
                property var sprite: ":label-background.png"
            }

            MapParameter {
                type: "layer"

                property var name: "markerArrow"
                property var layerType: "symbol"
                property var source: "routeSource"
            }

            MapParameter {
                type: "layout"

                property var layer: "markerArrow"
                property var iconImage: "label-arrow"
                property var iconSize: 0.5
                property var iconIgnorePlacement: true
                property var iconOffset: [ 0.0, -15.0 ]
                property var visibility: sourceGroup.checkedButton.text.startsWith("JSON") ? "visible" : "none"
            }

            MapParameter {
                type: "layer"

                property var name: "markerBackground"
                property var layerType: "symbol"
                property var source: "routeSource"
            }

            MapParameter {
                type: "layout"

                property var layer: "markerBackground"
                property var iconImage: "label-background"
                property var textField: "{name}"
                property var iconTextFit: "both"
                property var iconIgnorePlacement: true
                property var textIgnorePlacement: true
                property var textAnchor: "left"
                property var textSize: 16.0
                property var textPadding: 0.0
                property var textLineHeight: 1.0
                property var textMaxWidth: 8.0
                property var iconTextFitPadding: [ 15.0, 10.0, 15.0, 10.0 ]
                property var textOffset: [ -0.5, -1.5 ]
                property var visibility: sourceGroup.checkedButton.text.startsWith("JSON") ? "visible" : "none"
            }

            MapParameter {
                type: "paint"

                property var layer: "markerBackground"
                property var textColor: "white"
            }

            MapParameter {
                type: "filter"

                property var layer: "markerArrow"
                property var filter: [ "==", "$type", "Point" ]
            }

            MapParameter {
                type: "filter"

                property var layer: "markerBackground"
                property var filter: [ "==", "$type", "Point" ]
            }

            states: State {
                name: "moved"; when: map.gesture.panActive
                PropertyChanges { target: linePaint; lineColor: "red"; }
            }

            transitions: Transition {
                ColorAnimation { properties: "lineColor"; easing.type: Easing.InOutQuad; duration: 500 }
            }
        }

        back: Image {
            anchors.fill: parent
            source: "icon.png"
        }

        Component.onCompleted: {
            for (var i = 0; i < map.supportedMapTypes.length; i++) {
                styleModel.append({ text: map.supportedMapTypes[i].description });
            }
        }
    }

    Map {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 5

        width: 100
        height: 100

        gesture.enabled: false

        activeMapType: supportedMapTypes[4]
        copyrightsVisible: false

        plugin: Plugin {
            name: "mapboxgl"

            PluginParameter {
                name: "mapboxgl.mapping.cache.memory";
                value: true
            }
        }

        center: map.center
        zoomLevel: map.zoomLevel - 4
    }
}
