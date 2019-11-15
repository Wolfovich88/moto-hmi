import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: root

    property alias source: image.source
    property color color: "#80800000"

    implicitWidth: image.width
    implicitHeight: image.height

    Image {
        id: image

        anchors.fill: parent
    }

    ColorOverlay {
        anchors.fill: image
        source: image
        color: root.color
    }
}
