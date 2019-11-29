import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.5
import QtQuick.VirtualKeyboard 2.4

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 480
    title: qsTr("HMI")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        anchors.rightMargin: tabBar.width
        currentIndex: tabBar.currentIndex

        Page1Form {
        }

        Page2Form {
        }

        Page3Form {
        }
        Page4Form {
        }
        Page5Form {

        }
        Page6Form {

        }
    }

    Rectangle {
        id: vrButton

        visible: true

        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 15
            bottomMargin: 15
        }

        width: 70
        height: 70
        radius: width * 0.5
        color: Qt.rgba(214/360, 51/360, 190/360, 1)

        Image {
            source: "assets/vr.png"
            anchors.fill: parent
            anchors.margins: 5
        }

        MouseArea {
            anchors.fill: parent
            onClicked: vrLoader.active = true
        }
    }

    Loader {
        id: vrLoader

        anchors.fill: parent
        active: false

        sourceComponent: AnimatedImage {
            source: "assets/voice_wave.gif"

            MouseArea {
                anchors.fill: parent
                onClicked: vrLoader.active = false
            }
        }
    }

    Image {
        id: menuBackground
        width: 130

        anchors {
            right: parent.right
        }

        height: parent.height

        source: "assets/menu_big.png"
    }

    ListView {
        id: tabBar

        anchors {
            top: parent.top
            right: parent.right
        }
        width: 100
        height: parent.height
        interactive: false


        model: ListModel {
            ListElement {
                text: qsTr("Navigation")
            }
            ListElement {
                text: qsTr("Statistics")
            }
            ListElement {
                text: qsTr("Socials")
            }
            ListElement {
                text: qsTr("Profile")
            }
            ListElement {
                text: qsTr("Media")
            }
            ListElement {
                text: qsTr("Connections")
            }
        }

        delegate: HackButton {
            id: delegate

            text: model.text
            checked: index === tabBar.currentIndex
            width: tabBar.width
            height: window.height / tabBar.count

            onClicked: {
                swipeView.currentIndex = index
            }
        }
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    Rectangle {
        id: splashImage

        anchors.fill: parent
        color: "black"

        Image {
            source: "assets/logo.png"
            anchors.centerIn: parent
        }
    }

    NumberAnimation {
        id: splashAnimation
        target: splashImage
        from: 1
        to: 0
        duration: 3000
        property: "opacity"
        running: true
        easing.type: Easing.InQuint
    }
}
