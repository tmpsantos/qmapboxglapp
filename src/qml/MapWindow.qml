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
    property var night: true

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
                name: "mapboxgl.access_token"
                value: "pk.eyJ1IjoidG1wc2FudG9zIiwiYSI6ImNqMWVzZWthbDAwMGIyd3M3ZDR0aXl3cnkifQ.FNxMeWCZgmujeiHjl44G9Q"
            }

            PluginParameter {
                name: "mapboxgl.mapping.additional_style_urls"
                value: "mapbox://styles/mapbox/navigation-guidance-day-v2,mapbox://styles/mapbox/navigation-guidance-night-v2,mapbox://styles/mapbox/navigation-preview-day-v2,mapbox://styles/mapbox/navigation-preview-night-v2"
            }
        }

        activeMapType: {
            var style;

            if (mapWindow.navigating) {
                style = night ? supportedMapTypes[1] : supportedMapTypes[0];
            } else {
                style = night ? supportedMapTypes[3] : supportedMapTypes[2];
            }

            return style;
        }

        center: mapWindow.navigating ? ruler.currentPosition : map.center
        zoomLevel: 12.25
        minimumZoomLevel: 0
        maximumZoomLevel: 20
        tilt: 60

        copyrightsVisible: false

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-trunk-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-tunnel-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-tunnel-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-trunk-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-trunk-bg-low"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-bg-low"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-trunk-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-bridge-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-bridge-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layer"

            property var name: "3d-buildings"
            property var source: "composite"
            property var sourceLayer: "building"
            property var layerType: "fill-extrusion"
            property var minzoom: 15.0
        }

        MapParameter {
            type: "filter"

            property var layer: "3d-buildings"
            property var filter: [ "==", "extrude", "true" ]
        }

        MapParameter {
            type: "paint"

            property var layer: "3d-buildings"
            property var fillExtrusionColor: "#00617f"
            property var fillExtrusionOpacity: .6
            property var fillExtrusionHeight: { return { type: "identity", property: "height" } }
            property var fillExtrusionBase: { return { type: "identity", property: "min_height" } }
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
