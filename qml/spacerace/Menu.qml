import Qt 4.7

Image {
    id: menu
    property Item root

    anchors.centerIn: root
    source: "qrc:/space/img/menu.png"

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {}
        }
    }

    Rectangle {
        color: "green"
        width: 200
        anchors.top: parent.top
        anchors.bottom: parent.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.newGame();
            }
        }
    }
}
