import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Page {
    Rectangle {
        color: "black"
        anchors.fill: parent
    }

    Image {
        id: avatar

        width: 350
        height: 350
        anchors.centerIn: parent
        source: "assets/avatar.png"

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource:  Rectangle {
                width: avatar.width
                height: avatar.width
                radius: avatar.width * 0.5
            }
        }
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: avatar.bottom
        }

        text: "Tony Stark"
        anchors.topMargin: 10
        font.pixelSize: 34
        color: "white"
    }
}
