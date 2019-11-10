import QtQuick 2.12
import QtLocation 5.6
import QtPositioning 5.6

Item {
    width: 512
    height: 512
    visible: true

    property alias geoModel: geocodeModel

    function createRoute()
    {
        createRoute(QtPositioning.coordinate(56.3043872, 44.0183321),
                    QtPositioning.coordinate(56.3043872, 44.0183321))
    }
    function createRoute3(point1, point2)
    {
        routeModel.query.addWaypoint(point1)
        routeModel.query.addWaypoint(point2)
        routeModel.query.travelModes = RouteQuery.CarTravel
        routeModel.query.routeOptimizations = RouteQuery.FastestRoute
        // center the map on the start coord
        map.center = point1
        routeModel.update()
        console.debug("Model updated")
    }

    function createRoute2()
    {
        geocodeModel.query = toAddress
        geocodeModel.update()
    }

    function clearRoute()
    {
        console.debug("Clear route")
        routeModel.query.clearWaypoints()
        routeModel.reset()
    }

    Address {
        id :toAddress
        street: "8 Ковалихинская"
        city: "Нижний Новгород"
        country: "Россия"
        state : ""
        postalCode: ""
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

    GeocodeModel {
        id: geocodeModel
        plugin: mapPlugin
        autoUpdate: true
        onStatusChanged: {
            if (status == GeocodeModel.Ready)
            {
                console.debug("READY " + count)
                for(var i = 0 ; i < count; i++ )
                {
                    var addr = get(i).address
                    console.debug("Address: " + addr.country + ", "+ addr.city + ", "+ addr.street)
                }
                if (count > 0) {
                     var coord = get(0).coordinate
                    createRoute3(QtPositioning.coordinate(56.3043872, 44.0183321), coord)
                }
            }
            else if(status == GeocodeModel.Error)
                console.debug("ERROR")
        }
        onLocationsChanged:
        {
            if (count == 1) {
                map.center.latitude = get(0).coordinate.latitude
                map.center.longitude = get(0).coordinate.longitude
            }
        }
    }

    Map {
        id: map

        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(56.11, 44.75) // Oslo-huyoslo
        zoomLevel: 12

        MapItemView {
            model: geocodeModel
            delegate: MapQuickItem {
                width: 10
                height: 10
                sourceItem: Rectangle {
                    width: 10
                    height: 10
                }
            }
        }

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
