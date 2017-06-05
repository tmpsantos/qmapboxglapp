import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0

import com.mapbox.cheap_ruler 1.0

Item {
    id: mapWindow

    // Km/h
    property var carSpeed: 50
    property var navigating: true

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

    Image {
        anchors.left: parent.left
        anchors.right: parent.right
        z: 2

        source: "qrc:map-overlay-edge-gradient.png"
    }

    Image {
        anchors.right: parent.right
        anchors.top: parent.top
        z: 3

        source: "qrc:qt.png"
    }

    Image {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        z: 3

        source: "qrc:mapbox.png"
    }

    Image {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        z: 3

        visible: !mapWindow.navigating
        source: "qrc:car-focus.png"

        MouseArea {
            id: area

            anchors.fill: parent

            onClicked: {
                mapWindow.navigating = true
            }
        }

        scale: area.pressed ? 0.85 : 1.0

        Behavior on scale {
            NumberAnimation {}
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

        center: mapWindow.navigating ? ruler.currentPosition : map.center
        zoomLevel: 12.25
        minimumZoomLevel: 0
        maximumZoomLevel: 20
        tilt: 60

        activeMapType: supportedMapTypes[9] // Mapbox Traffic Night
        copyrightsVisible: false

        MouseArea {
            anchors.fill: parent

            onWheel: {
                mapWindow.navigating = false
                wheel.accepted = false
            }
        }
        gesture.onPanStarted: {
            mapWindow.navigating = false
        }

        gesture.onPinchStarted: {
            mapWindow.navigating = false
        }

        RotationAnimation on bearing {
            id: bearingAnimation

            duration: 250
            alwaysRunToEnd: false
            direction: RotationAnimation.Shortest
            running: mapWindow.navigating
        }

        Location {
            id: previousLocation
            coordinate: QtPositioning.coordinate(0, 0);
        }

        onCenterChanged: {
            if (previousLocation.coordinate == center || !mapWindow.navigating)
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

                    mapWindow.navigating = true
                }
            }
        }

        MapQuickItem {
            sourceItem: Image {
                id: carMarker
                source: "qrc:///car-marker.png"
            }

            coordinate: ruler.currentPosition
            anchorPoint.x: carMarker.width / 2
            anchorPoint.y: carMarker.height / 2
        }

        CheapRuler {
            id: ruler

            PropertyAnimation on currentDistance {
                id: currentDistanceAnimation

                duration: ruler.distance / mapWindow.carSpeed * 60 * 60 * 1000
                alwaysRunToEnd: false
            }
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
