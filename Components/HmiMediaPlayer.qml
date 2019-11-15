import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
    id: window
    width: 1280
    height: 720

    RowLayout {
        spacing: 115
        anchors.fill: parent
        anchors.margins: 70

        ColumnLayout {
            spacing: 26
            Layout.preferredWidth: 230

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "../assets/media/album-cover.jpg"
                }
            }

            Item {
                id: songLabelContainer
                clip: true

                Layout.fillWidth: true
                Layout.preferredHeight: songNameLabel.implicitHeight

                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite

                    PauseAnimation {
                        duration: 2000
                    }
                    ParallelAnimation {
                        XAnimator {
                            target: songNameLabel
                            from: 0
                            to: songLabelContainer.width - songNameLabel.implicitWidth
                            duration: 5000
                        }
                        OpacityAnimator {
                            target: leftGradient
                            from: 0
                            to: 1
                        }
                    }
                    OpacityAnimator {
                        target: rightGradient
                        from: 1
                        to: 0
                    }
                    PauseAnimation {
                        duration: 1000
                    }
                    OpacityAnimator {
                        target: rightGradient
                        from: 0
                        to: 1
                    }
                    ParallelAnimation {
                        XAnimator {
                            target: songNameLabel
                            from: songLabelContainer.width - songNameLabel.implicitWidth
                            to: 0
                            duration: 5000
                        }
                        OpacityAnimator {
                            target: leftGradient
                            from: 0
                            to: 1
                        }
                    }
                    OpacityAnimator {
                        target: leftGradient
                        from: 1
                        to: 0
                    }
                }

                Rectangle {
                    id: leftGradient
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#dfe4ea"
                        }
                        GradientStop {
                            position: 1
                            color: "#00dfe4ea"
                        }
                    }

                    width: height
                    height: parent.height
                    anchors.left: parent.left
                    z: 1
                    rotation: -90
                    opacity: 0
                }

                Label {
                    id: songNameLabel
                    text: "Edvard Grieg - In the Hall of the Mountain King"
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                }

                Rectangle {
                    id: rightGradient
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#00dfe4ea"
                        }
                        GradientStop {
                            position: 1
                            color: "#dfe4ea"
                        }
                    }

                    width: height
                    height: parent.height
                    anchors.right: parent.right
                    rotation: -90
                }
            }

            RowLayout {
                spacing: 16
                Layout.alignment: Qt.AlignHCenter

                RoundButton {
                    icon.source: "../assets/media/icons/favorite.png"
                    icon.width: 64
                    icon.height: 64
                }
                RoundButton {
                    icon.source: "../assets/media/icons/stop.png"
                    icon.width: 64
                    icon.height: 64
                }
                RoundButton {
                    icon.source: "../assets/media/icons/previous.png"
                    icon.width: 64
                    icon.height: 64
                }
                RoundButton {
                    icon.source: "../assets/media/icons/pause.png"
                    icon.width: 64
                    icon.height: 64
                }
                RoundButton {
                    icon.source: "../assets/media/icons/next.png"
                    icon.width: 64
                    icon.height: 64
                }
                RoundButton {
                    icon.source: "../assets/media/icons/repeat.png"
                    icon.width: 64
                    icon.height: 64
                }
                RoundButton {
                    icon.source: "../assets/media/icons/shuffle.png"
                    icon.width: 64
                    icon.height: 64
                }
            }

            Slider {
                id: seekSlider
                value: 113
                to: 261

                Layout.fillWidth: true

                ToolTip {
                    parent: seekSlider.handle
                    visible: seekSlider.pressed
                    text: pad(Math.floor(value / 60)) + ":" + pad(Math.floor(value % 60))
                    y: parent.height

                    readonly property int value: seekSlider.valueAt(seekSlider.position)

                    function pad(number) {
                        if (number <= 9)
                            return "0" + number;
                        return number;
                    }
                }
            }
        }

    }
}
