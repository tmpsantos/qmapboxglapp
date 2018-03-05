import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0
import QtQuick.Controls 2.2

ApplicationWindow {
    id: window

    title: "Mapbox GL for Qt"
    width: 1024
    height: 768
    visible: true

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

        center: QtPositioning.coordinate(60.170448, 24.942046) // Helsinki
        zoomLevel: 16
        minimumZoomLevel: 0
        maximumZoomLevel: 20
        tilt: 45

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
            }

            onCoordinateChanged: {
                map.updateRoute();
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
            }

            onCoordinateChanged: {
                map.updateRoute();
            }
        }

        MapItemView {
            model: routeModel

            delegate: MapRoute {
                route: routeData
                line.color: "blue"
                line.width: 4
                opacity: (index == 0) ? 1.0 : 0.3
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
