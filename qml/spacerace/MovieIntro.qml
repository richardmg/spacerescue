import Qt 4.7
import "global.js" as SharedScript

Rectangle {
    id: movieRoot
    color: "#000000"
    width: parent.width
    height: parent.height
    onHeightChanged: if (height != 10) astroids.reset();

    property Item _root: root

    Component.onCompleted: curtain.opacity = 0;

    UniverseBackground {
        id: bgStars
        bgimage: "qrc:/space/img/frontstars.gif"
        universeZ: 0.1
    }

    SpaceDebris {
        id: bgSun
        universeX: 200
        universeY: -200
        bgimage: "qrc:/space/img/sun.png"
        universeZ: 0.11
    }

    SpaceDebris {
        id: bgEarth
        universeX: -350
        universeY: 20
        bgimage: "qrc:/space/img/earth.png"
        universeZ: 0.2
    }

    UniverseBackground {
        id: bgBlueFog
        windX: 0.1
        windY: 0.1
        bgimage: "qrc:/space/img/universe.png"
        universeZ: 3
    }

    Challenger {
        id: challenger
        universeX: 100
        universeY: -80
        speedX: -0.6
    }

    Astronaut {
        id: astronaut
        universeX: -100
        universeY: -100
        speedX: -0.5
     }

    UniverseBackground {
        id: bgGrayFog
        windX: 0.2
        windY: 0.2
        bgimage: "qrc:/space/img/universetop2.png"
        universeZ: 6
    }

    Astroids {
        id: astroids
    }

    Indicator {
        id: indicator
        target: astronaut
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        onClicked: _root.endGame();
    }

    function checkScoreBoard()
    {
        switch (_root.gameTime) {
        case 550:
            challenger.explode();
            break;
        case 790:
            _root.endGame();
            break;
        }
//        console.debug(_root.gameTime)
    }

    Timer {
        id: gameTimer
        interval: 50;
        running: opacity > 0;
        repeat: true

        onTriggered: {
            challenger.gameStep();
            bgStars.gameStep();
            bgSun.gameStep();
            bgEarth.gameStep();
            bgBlueFog.gameStep();
            bgGrayFog.gameStep();
            astroids.gameStep();
            astronaut.gameStep();
            indicator.gameStep();
            checkScoreBoard();

            ++_root.gameTime;
            if (_root.gameTime == Number.MAX_VALUE)
                _root.gameTime = 0;
        }
    }

    Rectangle {
        id: curtain
        anchors.fill: parent
        color: "black"

        Behavior on opacity {
            SequentialAnimation {
                PropertyAnimation {
                    duration: 5000
                }
            }
        }
    }
}
