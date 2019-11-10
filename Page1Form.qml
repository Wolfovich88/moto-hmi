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
            bottom: parent.bottom
            right: speedLimitItem.left
            bottomMargin: 15
            rightMargin: 15
        }

        text: currentSpeed + " km/h"
        color: "lightgrey"
        font.pixelSize: 60
        font.bold: true
    }

    Rectangle {
        id: speedLimitItem

        anchors {
            right: parent.right
            bottom:parent.bottom
            rightMargin: 15
            bottomMargin: 15
        }

        width: 70
        height: 70
        radius: width * 0.5

        border.width: 10
        border.color: "red"

        Text {
            id: speedLimitText
            anchors.centerIn: parent
            text: qsTr("60")
            font.pointSize: 24
            font.bold: true
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
