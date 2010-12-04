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

    Image {
        id: startGame
        source: "qrc:/space/img/hal_newgame.png"
        anchors.top: parent.top
        anchors.bottom: parent.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.newGame();
            }
        }
    }
    Image {
        id: endGame
        source: "qrc:/space/img/hal.png"
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
