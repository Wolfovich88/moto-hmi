import QtQuick 2.12
import QtQuick.Controls 2.12
import QtLocation 5.6
import QtPositioning 5.6
import QtGraphicalEffects 1.1

import "./Components"

Item {
    width: 512
    height: 512
    visible: true

    property real latitude: 56.3043872
    property real longitude: 44.018332
    property var currentPosition:  QtPositioning.coordinate(latitude, longitude)

    function createRoute3(point1, point2)
    {
        clearRoute()
        routeModel.query.addWaypoint(point1)
        routeModel.query.addWaypoint(point2)
        routeModel.query.travelModes = RouteQuery.CarTravel
        routeModel.query.routeOptimizations = RouteQuery.FastestRoute
        // center the map on the start coord
        map.center = point1
        routeModel.update()
        console.debug("Model updated")
    }

    function searchPlace(addressText)
    {
        var arrdList = addressText.split(',')
        console.debug("New Address: " + arrdList + "Count: " + arrdList.length)

        for (var i = 0; i < arrdList.length; i++)
        {
            switch(i)
            {
            case 0:
                console.debug("Set street: " + arrdList[0])
                toAddress.street = arrdList[0];
                break
            case 1:
                console.debug("Set city: " + arrdList[1])
                toAddress.city = arrdList[1];
                break
            case 2:
                console.debug("Set country: " + arrdList[2])
                toAddress.country =  arrdList[2];
                break
            }
        }
        geocodeModel.query = toAddress
        console.debug("Start geocoding: " + toAddress.text)
        geocodeModel.update()
    }

    function clearRoute()
    {
        console.debug("Clear route")
        routeModel.query.clearWaypoints()
        routeModel.reset()
    }

    Address {
        id: toAddress
        street: "8 Ковалихинская"
        city: "Нижний Новгород"
        country: "Россия"
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
        onStatusChanged: {
            if (status == GeocodeModel.Ready)
            {
                console.debug("Found places: " + count)
                for(var i = 0 ; i < count; i++ )
                {
                    var addr = get(i).address
                    console.debug("Address: " + addr.country + ", "+ addr.city + ", "+ addr.street)
                }
                if (count > 0) {
                    var coord = get(0).coordinate
                    destinationPositionMarker.coordinate = coord
                    createRoute3(QtPositioning.coordinate(latitude, longitude), coord)
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

        property bool nightMode: true

        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(latitude, longitude)
        zoomLevel: 12
        activeMapType: nightMode ? supportedMapTypes[3] : supportedMapTypes[2]

        Component.onCompleted: {
            console.debug("MapTypes: " + supportedMapTypes)
            for (var i = 0; i<map.supportedMapTypes.length; i++) {
                console.debug("MapType: " +i + " " + map.supportedMapTypes[i].name)
            }
        }

        MapItemView {
            id: routeView

            model: routeModel
            delegate: MapRoute {
                route: routeData
                line.color: "lightgreen"
                line.width: 5
                smooth: true
            }
        }

        MapQuickItem {
            id: myPositionMarker

            anchorPoint.x: image.width/2
            anchorPoint.y: image.height/2
            coordinate: currentPosition

            sourceItem: ColoredImage {
                id: image

                width: 40
                height: 40
                color: map.nightMode ? "lightgrey" : "black"
                source: "assets/bike.png"
            }
        }

        MapQuickItem {
            id: destinationPositionMarker

            visible: routeModel.count > 0
            anchorPoint.x: image2.width/2
            anchorPoint.y: image2.height

            sourceItem: ColoredImage {
                id: image2

                width: 30
                height: 30
                source: "assets/marker.png"
                color: map.nightMode ? "lightgrey" : "black"
            }
        }
    }

    // Search text InputMethod

    TextInput {
        id: addressText
        anchors.left: parent.left
        anchors.right: clearBtn.left
        anchors.margins: 5
        anchors.top: parent.top
        font.family: "Helvetica"
        font.pointSize: 20
        color:map.nightMode ? "lightblue" : "blue"
        onAccepted: { searchPlace(addressText.text) }
    }

    Button {
        id: clearBtn

        visible: routeModel.count > 0
        height: addressText.height
        width: visible ? 2*height : 0
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 5

        text: "Clear"

        onClicked: {
            addressText.text = ""
            clearRoute()
        }
    }
}
