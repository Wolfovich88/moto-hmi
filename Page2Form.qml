import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.12

Page {

    Image {
        id: eco
        anchors.fill: parent
        source: "assets/mao-new.png"
    }

    RowMenu {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 25
        }

        model: ObjectModel {
            HackButton {
                text: "Map"
                checked: true

                onClicked: {
                    eco.source = "assets/map-eco-couching.png"
                }
            }

            HackButton {
                text: "Charts"

                onClicked: {
                    eco.source = "assets/graphics.png"
                }
            }
        }
    }
}
