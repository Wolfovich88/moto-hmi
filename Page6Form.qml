import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import "./Components"

Page {
    Rectangle {
        color: "black"
        anchors.fill: parent
    }

    ListModel {
        id: btModelFake
        ListElement {
            deviceName: "JBL pbx"
            service: false
            serviceName: "service 1"
            deviceAddress: "33:44:55:66"
            remoteAddress: ""
        }

        ListElement {
            deviceName: "JBL charge 3"
            service: false
            serviceName: "service 2"
            deviceAddress: "34:45:56:67"
            remoteAddress: ""
        }
    }

    ListView {
        id: mainList
        anchors.fill: parent
        anchors.margins: 10
        clip: true
        spacing: 5

        model: btModelFake

        delegate: Rectangle {
            id: btDelegate

            property bool paired: false

            width: parent.width
            height: 60
            color: "black"
            border.width: 1
            border.color: "white"
            clip: true

            Row {
                anchors.centerIn: parent
                height: parent.height - 10;
                width: parent.width - 10
                spacing: 10

                Image {
                    id: bticon
                    source: "assets/default.png";
                    width: parent.height
                    height: parent.height
                }

                Text {
                    id: bttext
                    text: deviceName + (btDelegate.paired ? " paired" : "")
                    height: parent.height
                    font.family: "FreeSerif"
                    font.pointSize: 16
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                }
            }

            ColorAnimation on color{
                id: press
                running: false
                from: "black"
                to: "grey"
                duration: 250
            }

            ColorAnimation on color{
                id: release
                running: false
                from: "grey"
                to: "black"
                duration: 250
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: btDelegate.paired = !btDelegate.paired
                onPressed: { release.stop(); press.start(); }
                onReleased: { press.stop(); release.start(); }
            }

            Timer {
                interval: 1500
                repeat: false
                running: false

                onTriggered: {
                    btDelegate.paired = !btDelegate.paired
                }
            }
        }
    }

    Button {
        id: fdButton
        width: 200
        height: 80
        highlighted: true
        flat: true
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Refresh"
    }
}
