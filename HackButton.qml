import QtQuick 2.0
import QtQuick.Controls 2.5

TabButton {
    id: root

    width: 70
    height: 70

    contentItem: Item {
        Text {
            anchors.centerIn: parent
            text: root.text
            color: "white"
        }
    }

    background: Rectangle {
        color: root.checked ? "black" : "transparent"
        opacity: 0.1
    }
}
