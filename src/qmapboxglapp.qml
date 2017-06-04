import QtGraphicalEffects 1.0
import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

import com.mapbox.cheap_ruler 1.0

ApplicationWindow {
    id: window

    // Km/h
    property var carSpeed: 50
    property var navigating: true

    title: "Mapbox GL for Qt 5.9"
    width: 1024
    height: 768
    visible: true

    Rectangle {
        anchors.fill: parent

        states: [
            State {
                name: ""
                PropertyChanges { target: map; tilt: 0; zoomLevel: map.zoomLevel }
            },
            State {
                name: "navigating"
                PropertyChanges { target: map; tilt: 60; zoomLevel: 20 }
            }
        ]

        state: navigating ? "navigating" : ""
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

    Map {
        id: map
        anchors.fill: parent

        plugin: Plugin {
            name: "mapboxgl"

            PluginParameter {
                name: "mapboxgl.mapping.use_fbo"
                value: true
            }
        }

        center: window.navigating ? ruler.currentPosition : map.center
        zoomLevel: 12.25
        minimumZoomLevel: 0
        maximumZoomLevel: 20
        tilt: 60

        MouseArea {
            anchors.fill: parent

            onWheel: {
                window.navigating = false
                wheel.accepted = false
            }
        }
        gesture.onPanStarted: {
            window.navigating = false
        }

        gesture.onPinchStarted: {
            window.navigating = false
        }

        RotationAnimation on bearing {
            id: bearingAnimation

            duration: 250
            alwaysRunToEnd: false
            direction: RotationAnimation.Shortest
            running: window.navigating
        }

        Location {
            id: previousLocation
            coordinate: QtPositioning.coordinate(0, 0);
        }

        onCenterChanged: {
            if (previousLocation.coordinate == center || !window.navigating)
                return;

            bearingAnimation.to = previousLocation.coordinate.azimuthTo(center);
            bearingAnimation.start();

            previousLocation.coordinate = center;
        }

        function updateRoute() {
            routeQuery.clearWaypoints();
            routeQuery.addWaypoint(startMarker.coordinate);
            routeQuery.addWaypoint(endMarker.coordinate);
        }

        MapQuickItem {
            id: startMarker

            sourceItem: Image {
                id: greenMarker
                source: "qrc:///marker-green.png"
            }

            coordinate : QtPositioning.coordinate(60.170448, 24.942046)
            anchorPoint.x: greenMarker.width / 2
            anchorPoint.y: greenMarker.height

            MouseArea  {
                drag.target: parent
                anchors.fill: parent

                onReleased: {
                    map.updateRoute();
                }
            }
        }

        MapQuickItem {
            id: endMarker

            sourceItem: Image {
                id: redMarker
                source: "qrc:///marker-red.png"
            }

            coordinate : QtPositioning.coordinate(60.180448, 24.942046)
            anchorPoint.x: redMarker.width / 2
            anchorPoint.y: redMarker.height

            MouseArea  {
                drag.target: parent
                anchors.fill: parent

                onReleased: {
                    map.updateRoute();
                }
            }
        }

        MapItemView {
            model: routeModel

            delegate: MapRoute {
                route: routeData
                line.color: "blue"
                line.width: 4
                opacity: (index == 0) ? 1.0 : 0.3

                onRouteChanged: {
                    ruler.path = routeData.path;
                    ruler.currentDistance = 0;

                    currentDistanceAnimation.stop();
                    currentDistanceAnimation.to = ruler.distance;
                    currentDistanceAnimation.start();

                    window.navigating = true
                }
            }
        }

        MapCircle {
            center: ruler.currentPosition
            radius: 2
            color: 'red'
        }

        CheapRuler {
            id: ruler

            PropertyAnimation on currentDistance {
                id: currentDistanceAnimation

                duration: ruler.distance / window.carSpeed * 60 * 60 * 1000
                alwaysRunToEnd: false
            }
        }
    }

    Component.onCompleted: {
        for (var i = 0; i < map.supportedMapTypes.length; i++) {
            styleModel.append({ text: map.supportedMapTypes[i].description });
        }
    }

    RouteModel {
        id: routeModel

        autoUpdate: true
        query: routeQuery

        plugin: Plugin {
            name: "mapbox"

            // Development access token, do not use in production.
            PluginParameter {
                name: "mapbox.access_token"
                value: "pk.eyJ1IjoicXRzZGsiLCJhIjoiY2l5azV5MHh5MDAwdTMybzBybjUzZnhxYSJ9.9rfbeqPjX2BusLRDXHCOBA"
            }
        }

        Component.onCompleted: {
            if (map) {
                map.updateRoute();
            }
        }
    }

    RouteQuery {
        id: routeQuery
    }
}
