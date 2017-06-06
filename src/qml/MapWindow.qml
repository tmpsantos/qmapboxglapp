import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0

import com.mapbox.cheap_ruler 1.0

Item {
    id: mapWindow

    // Km/h
    property var carSpeed: 35
    property var navigating: true
    property var traffic: true

    states: [
        State {
            name: ""
            PropertyChanges { target: map; tilt: 0; bearing: 0; zoomLevel: map.zoomLevel }
        },
        State {
            name: "navigating"
            PropertyChanges { target: map; tilt: 60; zoomLevel: 20 }
        }
    ]

    transitions: [
        Transition {
            to: "*"
            RotationAnimation { target: map; property: "bearing"; duration: 100; direction: RotationAnimation.Shortest }
            NumberAnimation { target: map; property: "zoomLevel"; duration: 100 }
            NumberAnimation { target: map; property: "tilt"; duration: 100 }
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
        anchors.bottom: parent.bottom
        anchors.margins: 5
        anchors.bottomMargin: 270

        z: 3

        source: "qrc:qt.png"
    }

    Image {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 5
        anchors.bottomMargin: 270

        z: 3

        source: "qrc:mapbox.png"
    }

    CustomLabel {
        id: turnInstructions

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        z: 3

        font.pixelSize: 38
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
                name: "mapboxgl.mapping.items.insert_before"
                value: "road-label-small"
            }

            PluginParameter {
                name: "mapboxgl.mapping.additional_style_urls"
                value: "mapbox://styles/tmpsantos/cj3loga9r00142sqnchfae6ta"
            }

            PluginParameter {
                name: "mapboxgl.access_token"
                value: "pk.eyJ1IjoidG1wc2FudG9zIiwiYSI6ImNqMWVzZWthbDAwMGIyd3M3ZDR0aXl3cnkifQ.FNxMeWCZgmujeiHjl44G9Q"
            }
        }

        center: mapWindow.navigating ? ruler.currentPosition : map.center
        zoomLevel: 12.25
        minimumZoomLevel: 0
        maximumZoomLevel: 20
        tilt: 60

        copyrightsVisible: false

        MapParameter {
            type: "layout"

            property var layer: "traffic-3-motorway"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-3-motorway-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-2-motorway"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-2-motorway-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-1-motorway"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-1-motorway-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-0-motorway"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-0-motorway-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-3-other"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-3-other-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-3-other-high"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-3-other-high-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-2-other"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-2-other-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-2-other-high"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-2-other-high-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-1-other"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-1-other-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-1-other-high"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-1-other-high-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-0-other"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-0-other-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-0-other-high"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-0-other-high-case"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

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

            coordinate : QtPositioning.coordinate(37.7881955, -122.4003401)
            anchorPoint.x: greenMarker.width / 2
            anchorPoint.y: greenMarker.height / 2

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

            coordinate : QtPositioning.coordinate(37.326323, -121.8923447)
            anchorPoint.x: redMarker.width / 2
            anchorPoint.y: redMarker.height / 2

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
                line.color: "#ec0f73"
                line.width: map.zoomLevel - 5
                opacity: (index == 0) ? 1.0 : 0.3

                onRouteChanged: {
                    ruler.path = routeData.path;
                    ruler.currentDistance = 0;

                    currentDistanceAnimation.stop();
                    currentDistanceAnimation.to = ruler.distance;
                    currentDistanceAnimation.start();
                }
            }
        }

        MapQuickItem {
            zoomLevel: map.zoomLevel

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

            onCurrentDistanceChanged: {
                var total = 0;
                var i = 0;

                // XXX: Use car speed in meters to pre-warn the turn instruction
                while (total - mapWindow.carSpeed < ruler.currentDistance * 1000 && i < routeModel.get(0).segments.length)
                    total += routeModel.get(0).segments[i++].maneuver.distanceToNextInstruction;

                turnInstructions.text = routeModel.get(0).segments[i - 1].maneuver.instructionText;
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
