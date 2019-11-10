import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: rectangle

    Column {
        id: column
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
    }

    Text {
        id: element
        x: 275
        y: 20
        text: qsTr("Address")
        font.pixelSize: 12
    }

    TextInput {
        id: textInput
        x: 256
        y: 76
        width: 80
        height: 20
        text: qsTr("Text Input")
        font.pixelSize: 12
    }

    ListView {
        id: listView
        x: 241
        y: 207
        width: 110
        height: 160
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                Rectangle {
                    width: 40
                    height: 40
                    color: colorCode
                }

                Text {
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                spacing: 10
            }
        }
        model: ListModel {
            ListElement {
                name: "Grey"
                colorCode: "grey"
            }

            ListElement {
                name: "Red"
                colorCode: "red"
            }

            ListElement {
                name: "Blue"
                colorCode: "blue"
            }

            ListElement {
                name: "Green"
                colorCode: "green"
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:400;anchors_width:200;anchors_x:189;anchors_y:40}
}
##^##*/
