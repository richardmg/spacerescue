import Qt 4.7
import "global.js" as SharedScript

Rectangle {
    id: top
    width: 800
    height: 600
    color: "#000000"

    Component.onCompleted: {
        SharedScript.screenWidth = top.width;
        SharedScript.screenHeight = top.height;
    }

    UniverseBackground {
        id: bgStars
        bgimage: "qrc:/space/img/frontstars.gif"
        universeZ: 0.1
    }

    PlanetBackground {
        id: bgSun
        universeX: 500
        universeY: 100
        bgimage: "qrc:/space/img/sun.png"
        universeZ: 0.11
    }

    PlanetBackground {
        id: bgEarth
        universeX: -100
        universeY: 280
        bgimage: "qrc:/space/img/earth.png"
        universeZ: 0.2
    }

    PlanetBackground {
        id: bgMoon
        universeX: 0//1200
        universeY: 0//600
        bgimage: "qrc:/space/img/moon.png"
        universeZ: 0.3
    }

    UniverseBackground {
        id: bgBlueFog
        windX: 0.1
        windY: 0.1
        bgimage: "qrc:/space/img/universe.png"
        universeZ: 3
    }

    RaceTrack {
        id: raceTrack
    }

    Spaceship {
        id: ship
        x: top.width / 2
        y: top.height / 2
        mouseControlled: mousearea.pressed
        onUniverseXChanged: SharedScript.cameraX = universeX;
        onUniverseYChanged: SharedScript.cameraY = universeY;
    }

    UniverseBackground {
        id: bgGrayFog
        windX: 0.2
        windY: 0.2
        bgimage: "qrc:/space/img/universetop2.png"
        universeZ: 6
    }

//    Repeater {
//        model: 10
        SpaceDebris {
            id: rock1
            imageCount: 32
            bgimage: "qrc:/space/img/rock1/rock100"
        }
//    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: ship.setUniverseDirection(mouse.x, mouse.y)
    }

    Timer {
        id: gameTimer
        interval: 50;
        running: true;
        repeat: true

        onTriggered: {
            ship.gameStep();
            bgStars.gameStep();
            bgSun.gameStep();
            bgEarth.gameStep();
            bgMoon.gameStep();
            bgBlueFog.gameStep();
            bgGrayFog.gameStep();
            rock1.gameStep();
            raceTrack.gameStep();
        }
    }

}
