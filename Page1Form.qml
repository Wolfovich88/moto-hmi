import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.12
import QtLocation 5.6
import QtPositioning 5.6

Page {

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
        color: "black"
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

    TextEdit {
        width: 300
        height: 80
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        text: ""
        font.family: "Helvetica"
        font.pointSize: 20
        color: "blue"
        focus: true

        onTextChanged: {
            map.createRoute2()
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
                text: "Search"

                onClicked: {
                    map.createRoute2()
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
