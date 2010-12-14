import Qt 4.7
import "global.js" as SharedScript

Rectangle {
    id: movieRoot
    color: "#000000"
    width: parent.width
    height: parent.height
    onWidthChanged: debris.reset();
    onHeightChanged: debris.reset();

    property Item root

    Component.onCompleted: curtain.opacity = 0;

    UniverseBackground {
        id: bgStars
        bgimage: "qrc:/space/img/frontstars.gif"
        universeZ: 0.1
    }

    PlanetBackground {
        id: bgSun
        universeX: 200
        universeY: -200
        bgimage: "qrc:/space/img/sun.png"
        universeZ: 0.11
    }

    PlanetBackground {
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
        universeX: 0
        universeY: -50
        speedX: -0.7
    }

    Astronaut {
        id: astronaut
        universeX: 130
        universeY: 100
        speedX: -0.8
     }

    UniverseBackground {
        id: bgGrayFog
        windX: 0.2
        windY: 0.2
        bgimage: "qrc:/space/img/universetop2.png"
        universeZ: 6
    }

    SpaceDebrisContainer {
        id: debris
    }

    Indicator {
        id: indicator
        target: astronaut
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        onClicked: movieRoot.root.endGame();
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
            debris.gameStep();
            astronaut.gameStep();
            indicator.gameStep();

            ++SharedScript.gameTime;
            if (SharedScript.gameTime == Number.MAX_VALUE)
                SharedScript.gameTime = 0;

            if (SharedScript.gameTime == 320) {
                challenger.explode();
            }
//            console.debug(SharedScript.gameTime)
        }
    }

    Rectangle {
        id: curtain
        anchors.fill: parent
        color: "black"

        Behavior on opacity {
            SequentialAnimation {
                PropertyAnimation {
                    duration: 3000
                }
            }
        }
    }
}
