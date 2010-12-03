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
        id: startGame
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
    Rectangle {
        id: endGame
        color: "red"
        width: 200
        anchors.top: startGame.bottom
        anchors.bottom: parent.bottom
        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.quit();
            }
        }
    }
}
