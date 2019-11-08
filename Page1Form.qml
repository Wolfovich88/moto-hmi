import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.12
import QtLocation 5.6
import QtPositioning 5.6

Page {

    Plugin {
        id: mapPlugin
        //name: "osm"
        name: "mapboxgl"
        //name: "esri"
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
                    console.debug("Route error!")
                    break
                case 1:
                     console.debug("Route ready!")
                    break
                }
            } else {
                console.debug("Route error!")
            }
        }
    }

    HmiMap {
        id: map
        anchors.fill: parent
    }

    Text {
        id: speedText

        property int currentSpeed: 50
        property bool isIncrease: true

        anchors {
            top: parent.top
            left: parent.left
            topMargin: 10
            leftMargin: 10
        }

        text: currentSpeed + " km/h"
        color: "white"
        font.pixelSize: 60
        font.bold: true
    }

    Rectangle {

        anchors {
            right: parent.right
            top:parent.top
            rightMargin: 20
            topMargin: 20
        }

        width: 100
        height: 100
        radius: width * 0.5

        border.width: 10
        border.color: "red"

        Text {
            id: speedLimit
            anchors.centerIn: parent
            text: qsTr("90")
            font.pointSize: 40
            font.bold: true
        }
    }

    RowMenu {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 25
        }

        model: ObjectModel {
            HackButton {
                text: "Map"
                checked: true

                onClicked: {
                    map.clearRoute()
                }
            }

            HackButton {
                text: "Routing"

                onClicked: {
                     map.createRoute()
                }
            }
        }
    }

    Timer {
        interval: 200
        repeat: true
        running: true

        onTriggered: {
            if (speedText.isIncrease && speedText.currentSpeed < 70) {
                ++speedText.currentSpeed
            }
            else {
                speedText.isIncrease = false
            }

            if (!speedText.isIncrease && speedText.currentSpeed > 50) {
                --speedText.currentSpeed
            }
            else {
                speedText.isIncrease = true
            }

        }

    }
}
