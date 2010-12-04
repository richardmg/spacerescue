import Qt 4.7

Image {
    id: menu
    property Item root
    property Item rescueTimer: menuTimer
    source: "qrc:/space/img/menu.png"

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {}
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: menuTimer.height + 20
        color: "black"
        opacity: 0.7
    }

    Image {
        id: startGame
        source: "qrc:/space/img/hal_newgame.png"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
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
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.quit();
            }
        }
    }

    RescueTimer {
        id: menuTimer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
    }
}
