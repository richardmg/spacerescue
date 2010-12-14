import Qt 4.7
import "global.js" as SharedScript

Rectangle {
    id: gameRoot
    color: "#000000"
    width: parent.width
    height: parent.height
    onWidthChanged: debris.reset();
    onHeightChanged: debris.reset();
    focus: opacity > 0;

    property Item root
    property alias rescueTimer: rescueTimer

    UniverseBackground {
        id: bgStars
        bgimage: "qrc:/space/img/frontstars.gif"
        universeZ: 0.1
    }

    SpaceBackground {
        id: bgSun
        universeX: 600
        universeY: -150
        bgimage: "qrc:/space/img/sun.png"
        universeZ: 0.11
    }

    SpaceBackground {
        id: bgEarth
        universeX: 250
        universeY: 0
        bgimage: "qrc:/space/img/earth.png"
        universeZ: 0.2
    }

    SpaceBackground {
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

    SpaceBackground {
        id: spacestation
        universeX: -350
        universeY: -150
        universeZ: 0.6
        rotationSpeed: -0.04
        imageCount: 2
        imageSpeed: 50
        bgimage: "qrc:/space/img/spacestation"
    }

    SpaceBackground {
        id: challenger_top
        universeX: 1900
        universeY: -300
        universeZ: 0.5
        rotationSpeed: 1
        bgimage: "qrc:/space/img/challenger_top.png"
    }

    SpaceBackground {
        id: challenger_bottom
        universeX: 1500
        universeY: 200
        universeZ: 0.5
        rotationSpeed: -1
        bgimage: "qrc:/space/img/challenger_bottom.png"
    }

    Astronaut {
        id: astronaut
        root: game.root
     }

    Spaceship {
        id: ship
        x: gameRoot.width / 2
        y: gameRoot.height / 2
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

    RescueTimer {
        id: rescueTimer
        x: 10
        y: 10
        opacity: 0;
    }

    Timer {
        id: gameTimer
        interval: 50;
        running: false;
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
            challenger_top.gameStep();
            challenger_bottom.gameStep();
            spacestation.gameStep();

            ++SharedScript.gameTime;
            if (SharedScript.gameTime == Number.MAX_VALUE)
                SharedScript.gameTime = 0;
        }
    }

    Keys.onPressed: {
        gameRoot.root.endGame()
    }

    function newGame()
    {
        SharedScript.reset(SharedScript.level);
        ship.reset();
        debris.reset();
        astronaut.reset();
        rescueTimer.reset();
        rescueTimer.running = true;
        rescueTimer.menuMode = false
        rescueTimer.opacity = 1;
        gameTimer.running = true;
    }

    function endGame()
    {
        gameTimer.running = false;
        rescueTimer.running = false;
    }
}
