import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root

    property alias model: repeater.model

    width: row.width
    height: row.height
    color: "grey"
    radius: 10

    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Rectangle {
            width: root.width
            height: root.height
            radius: 10
        }
    }

    Row {
        id: row

        Repeater {
            id: repeater
        }
    }
}
