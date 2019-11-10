import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import "./Components"
Page {
    Rectangle {
        color: "black"
        anchors.fill: parent
    }

    HmiMediaPlayer {
        anchors.fill: parent
    }
}
