import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.12

Page {
    width: 600
    height: 400

    Rectangle {
        color: "black"
        anchors.fill: parent
    }

    Image {
        anchors.centerIn: parent
        source: "assets/socials.png"
    }

//    TextField {
//        id: textInput
//        anchors {
//            top: parent.top
//            topMargin: 10
//            horizontalCenter: parent.horizontalCenter
//        }
//        width: parent.width - 20
//        placeholderText: "Enter message"
//    }

//    ListView {
//        anchors.fill: parent
//        anchors.leftMargin: 50
//        anchors.rightMargin: 50
//        anchors.topMargin: textInput.height + 20
//        model: 20
//        spacing: 5
//        clip: true
//        delegate: Rectangle {
//            width: parent.width
//            height: 50
//            radius: 5
//            color: Qt.rgba(153/360, 201/360, 196/360, 1)
//            border.width: 2
//            border.color: "gray"
//            Text {
//                anchors.centerIn: parent
//                text: "Chat %1".arg(index)
//                color: "white"
//            }

//        }
//    }
}
