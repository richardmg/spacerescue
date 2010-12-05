import Qt 4.7
import "global.js" as SharedScript

Image {
    id: menu
    property Item root
    property Item rescueTimer: menuTimer
    property string level: levelInput.text;
    source: "qrc:/space/img/menu.png"

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {}
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: startGame.height
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
                SharedScript.level = parseInt(menu.level);
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

    Text {
        id: levelLabel
        anchors.bottom: menuTimer.top
        anchors.left: startGame.right
        anchors.leftMargin: 50

        text: "Level:"
        color: "white"
    }

    TextInput {
        id: levelInput
        width:  250
        anchors.bottom: menuTimer.top
        anchors.left: levelLabel.right
        anchors.leftMargin: 20
        text: "20"
        color: "red"
        cursorVisible: true
    }

    Text {
        id: timerLabel
        anchors.left: startGame.right
        anchors.leftMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25

        text: "Time:"
        color: "white"
    }

    RescueTimer {
        id: menuTimer
        anchors.left: timerLabel.right
        anchors.leftMargin: 20
        anchors.bottom: timerLabel.bottom
        color: "red"
    }

    Timer {
        id: gameTimer
        interval: 50;
        running: true;
        repeat: true

        onTriggered: {
            bgGrayFog.gameStep();
        }
    }

    UniverseBackground {
        id: bgGrayFog
        windX: 3.2
        windY: 0.2
        bgimage: "qrc:/space/img/universetop2.png"
        universeZ: 10
    }

}
