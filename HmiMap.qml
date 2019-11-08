import QtQuick 2.12
import QtLocation 5.6
import QtPositioning 5.6

Item {
    width: 512
    height: 512
    visible: true

    function createRoute()
    {
        routeModel.query.addWaypoint(QtPositioning.coordinate(56.3043872, 44.0183321))
        routeModel.query.addWaypoint(QtPositioning.coordinate(56.044765,45.8236494))
        routeModel.query.travelModes = RouteQuery.CarTravel
        routeModel.query.routeOptimizations = RouteQuery.FastestRoute
        // center the map on the start coord
        map.center = QtPositioning.coordinate(56.3043872, 44.0183321)
        routeModel.update()
        console.debug("Model updated")
    }

    function clearRoute()
    {
        console.debug("Clear route")
        routeModel.query.clearWaypoints()
        routeModel.reset()
    }

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
        // specify plugin parameters if necessary
        // PluginParameter {
        //     name:
        //     value:
        // }
    }

    RouteModel {
        id: routeModel
        plugin: mapPlugin
        query:  RouteQuery {
            id: routeQuery
        }
        onStatusChanged: {
            if (status == RouteModel.Ready) {
                console.debug("Route created: " + count)
                switch (count) {
                case 0:
                    console.debug("No routes found!")
                    break
                case 1:
                    console.debug("Route found!")
                    break
                }
            } else if (status == RouteModel.Error) {
                console.debug("Route error! " + errorString)
            }
        }
    }

    Map {
        id: map

        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(56.11, 44.75) // Oslo
        zoomLevel: 14

        MapItemView {
            model: routeModel
            delegate: MapRoute {
                route: routeData
                line.color: "green"
                line.width: 5
                smooth: true
            }
        }
    }
}
