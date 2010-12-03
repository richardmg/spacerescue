import Qt 4.7
import "global.js" as SharedScript

Rectangle {
    id: top
    color: "#000000"
    width: 480
    height: 800
    onWidthChanged: { SharedScript.screenWidth = width; debris.reset(); }
    onHeightChanged: { SharedScript.screenHeight = height; debris.reset(); }
    focus: true

    UniverseBackground {
        id: bgStars
        bgimage: "qrc:/space/img/frontstars.gif"
        universeZ: 0.1
    }

    PlanetBackground {
        id: bgSun
        universeX: 600
        universeY: -150
        bgimage: "qrc:/space/img/sun.png"
        universeZ: 0.11
    }

    PlanetBackground {
        id: bgEarth
        universeX: 250
        universeY: 0
        bgimage: "qrc:/space/img/earth.png"
        universeZ: 0.2
    }

    PlanetBackground {
        id: bgMoon
        universeX: 1100
        universeY: 100
        bgimage: "qrc:/space/img/moon.png"
        universeZ: 0.25
    }

    UniverseBackground {
        id: bgBlueFog
        windX: 0.1
        windY: 0.1
        bgimage: "qrc:/space/img/universe.png"
        universeZ: 3
    }

    Astronaut {
        id: astronaut
        ship: ship
        root: top
     }

    Spaceship {
        id: ship
        x: top.width / 2
        y: top.height / 2
        mouseControlled: mousearea.pressed
        onUniverseXChanged: SharedScript.cameraX = universeX
        onUniverseYChanged: SharedScript.cameraY = universeY;
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
        ship: ship
    }

    Indicator {
        id: indicator
        target: astronaut
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: ship.setUniverseDirection(mouse.x, mouse.y)
    }

    Menu {
        id: menu
        root: top
    }

    RescueTimer {
        id: rescueTimer
        x: 10
        y: 10
    }

    Keys.onPressed: {
        endGame()
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
            debris.gameStep();
            astronaut.gameStep();
            indicator.gameStep();
            rescueTimer.gameStep();

            ++SharedScript.gameTime;
            if (SharedScript.gameTime == Number.MAX_VALUE)
                SharedScript.gameTime = 0;
        }
    }

    function newGame()
    {
        SharedScript.reset();
        ship.reset();
        debris.reset();
        astronaut.reset();
        rescueTimer.reset();
        rescueTimer.running = true;
        rescueTimer.menuMode = false
        menu.opacity = 0;
    }

    function endGame()
    {
        menu.opacity = 1;
        rescueTimer.running = false;
        rescueTimer.menuMode = true
    }
}
