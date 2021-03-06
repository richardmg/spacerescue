import Qt 4.7
import "global.js" as SharedScript

Image {
    id: menu
    property Item _root: root
    property Item rescueTimer: menuTimer
    source: "qrc:/space/img/menu.png"

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {
                duration: 1000
            }
        }
    }

    Rectangle {
        width: parent.width
        anchors.top:  leveldown.top
        anchors.bottom: leveldown.bottom
        color: "white"
        opacity: 0.4
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

    Image {
        id: leveldown
        source: "qrc:/space/img/levelarrowdown.png"
        anchors.bottom: parent.bottom
        anchors.left: startGame.right
        MouseArea {
            anchors.fill: parent
            onPressed: {
                _root.level = Math.max(0, (_root.level - 1));
                levelLabel.text = "Level: " + _root.level;
            }
        }
    }
    Image {
        id: levelup
        source: "qrc:/space/img/levelarrowup.png"
        anchors.bottom: parent.bottom
        anchors.right: endGame.left
        MouseArea {
            anchors.fill: parent
            onPressed: {
                _root.level++;
                levelLabel.text = "Level: " + _root.level;
            }
        }
    }

    Text {
        anchors.top: levelup.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 13
        font.pointSize: 32
        font.bold: true
        text: levelLabel.text
        color: "black"
    }

    Text {
        id: levelLabel
        anchors.top: levelup.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        font.pointSize: 32
        font.bold: true
        text: "Level: " + _root.level;
        color: "red"
    }

    RescueTimer {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: levelup.bottom
        anchors.bottomMargin: 7
        color: "black"
        font.pointSize: 22
        font.bold: true
        hours: menuTimer.hours
        minutes: menuTimer.minutes
        seconds: menuTimer.seconds
        milliseconds: menuTimer.milliseconds
    }

    RescueTimer {
        id: menuTimer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: levelup.bottom
        anchors.bottomMargin: 10
        color: "red"
        font.pointSize: 22
        font.bold: true
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
